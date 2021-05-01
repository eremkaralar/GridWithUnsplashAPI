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
    
    private let spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Images"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureCollectionViewCell.nib(), forCellWithReuseIdentifier: "PictureCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
               layout.minimumLineSpacing = spacing
               layout.minimumInteritemSpacing = spacing
               self.collectionView?.collectionViewLayout = layout
        
      
        
        
        
        // Do any additional setup after loading the view.
        // Querying pictures
        
        networker.posts(query: "Car") { [weak self] posts, error in
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
        
               cell.layer.cornerRadius = 15.0
               cell.layer.borderWidth = 0.0
               cell.layer.shadowColor = UIColor.black.cgColor
               cell.layer.shadowOffset = CGSize(width: 0, height: 0)
               cell.layer.shadowRadius = 5.0
               cell.layer.shadowOpacity = 1
               cell.layer.masksToBounds = false
        
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 16
    
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
                
                if let collection = self.collectionView{
                    let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                    return CGSize(width: width, height: width)
                }else{
                    return CGSize(width: 0, height: 0)
                }
    }
    
    
}

