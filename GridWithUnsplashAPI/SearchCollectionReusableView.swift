//
//  SearchCollectionReusableView.swift
//  GridWithUnsplashAPI
//
//  Created by Erem Karalar on 30.04.2021.
//

import Foundation
import UIKit

class SearchCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var searchBar: UISearchBar!
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)

                return headerView
            }

            return UICollectionReusableView()
    
     }
}
