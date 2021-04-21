//
//  Model.swift
//  GridWithUnsplashAPI
//
//  Created by Erem Karalar on 20.04.2021.
//

import Foundation

struct Post : Codable{
    var id : String
    var urls : URLs
}


struct URLs : Codable{
    var regular : String
    
}
