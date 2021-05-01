//
//  Model.swift
//  GridWithUnsplashAPI
//
//  Created by Erem Karalar on 20.04.2021.
//

import Foundation

struct Post : Codable{
    var id : String
    var urls : PostUrls
}
struct PostUrls : Codable{
    var regular : String
}
