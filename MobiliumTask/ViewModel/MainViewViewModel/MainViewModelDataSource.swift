//
//  MainViewModelDataSource.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 31.03.2022.
//

import Foundation
import UIKit
import SDWebImage
import ImageSlideshow

class MainViewModelDataSource{
    var sliderMovieList: [MovieInfoModel]
    var movieList : [MovieInfoModel]
    var currentPageNumber:Int
    var totalPages:Int
    var sliderImageResources: [SDWebImageSource]

    init() {
        sliderImageResources = []
        sliderMovieList = []
        movieList = []
        currentPageNumber = 1
        totalPages = 100 // default upper limit
    }
}

