//
//  MovieModel.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 29.03.2022.
//

import Foundation


struct MoviesResponseModel: Codable {
    let dates: Dates
    let page: Int
    let results: [MovieInfoModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct MovieInfoModel: Codable {
    let adult: Bool
    var backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    func dateFormating() -> String{
        let replacedDate = String(releaseDate.map{
            $0 == "-" ? " " : $0
        })
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy mm dd"
        dateFormatter.locale = Locale.init(identifier: "en_GB")

        let dateObj = dateFormatter.date(from: replacedDate)

        dateFormatter.dateFormat = "MM-dd-yyyy"

        let finalDateFormat = String(dateFormatter.string(from: dateObj!).map{
            $0 == "-" ? "." : $0
        })

        return finalDateFormat
    }
    func year() -> String{
        return String(releaseDate.prefix(4))
    }
}
