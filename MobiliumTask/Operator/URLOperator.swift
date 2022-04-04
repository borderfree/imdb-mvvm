//
//  Operator.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 30.03.2022.
//

import Foundation
import UIKit

//URL adreslerinin toplandığı yerdir. Hem okunabilirliği yükseltmesi hem de düzenli olması sebebiyle structlarda ayrı ayrı tanımlandı.

struct Domain {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageURL = "https://image.tmdb.org/t/p/w185/"
    
}

extension Domain {
    static func baseUrl() -> String {
        return Domain.baseURL
    }
}

struct APIEndpoint {
    static let movie = "/movie/"
    static let upcomingMoviePath = "/movie/upcoming"
    static let nowPlayingMoviePath = "/movie/now_playing"
}

struct APIKey {
    static let key = "9e7693d576c147c2b7472ceadd36cb23"
}
