//
//  DetailViewModel.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 2.04.2022.
//

import Foundation
import UIKit


class DetailViewModel {
    weak var viewController: DetailViewController?
    private var dataModel: DetailViewData


    init(_ movieInfoModel: MovieInfoModel) {
        dataModel = DetailViewData(movieInfoModel)
    }

    func movieInfoModel() -> MovieInfoModel {
        return dataModel.movieInfoModel
    }

    func movieTitle() -> String {
        return dataModel.movieInfoModel.title
    }

    func movieImageURLString() -> String{
        return Domain.imageURL+(dataModel.movieInfoModel.backdropPath ?? "")
    }

    func movieRate() -> Double{
        return (dataModel.movieInfoModel.voteAverage)
    }
}
