//
//  IMDB.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 4.04.2022.
//

import Foundation
struct IMDBID:Codable {
    let imdbId: String
    enum CodingKeys:String,CodingKey{
        case imdbId = "imdb_id"
    }
}
