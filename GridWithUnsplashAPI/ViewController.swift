//
//  ViewController.swift
//  GridWithUnsplashAPI
//
//  Created by Erem Karalar on 20.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let networker = NetworkManager.shared
      
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Pictures"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureCollectionViewCell.nib(), forCellWithReuseIdentifier: "PictureCollectionViewCell")
        // Do any additional setup after loading the view.
        // Querying pictures
        networker.posts(query: "Galatasaray University") { [weak self] posts, error in
              if let error = error {
                print("Error occured!", error)
                return
              }
              
              self?.posts = posts!
              DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Tapped!")
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as! PictureCollectionViewCell
        
        let post = posts[indexPath.item]
        cell.image = nil
           
            
            let representedIdentifier = post.id
            cell.representedIdentifier = representedIdentifier
            
            func image(data: Data?) -> UIImage? {
              if let data = data {
                return UIImage(data: data)
              }
              return UIImage(systemName: "picture")
            }
            
            networker.image(post: post) { data, error  in
              let img = image(data: data)
              DispatchQueue.main.async {
                if (cell.representedIdentifier == representedIdentifier) {
                  cell.image = img
                }
              }
            }

            return cell
          
    }

}

