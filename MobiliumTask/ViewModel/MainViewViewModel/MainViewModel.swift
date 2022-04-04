//
//  MainViewControllerProtocol.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 30.03.2022.
//

import Foundation
import UIKit



class MainViewModel: MainViewModelProtocol {
    weak var viewController: ViewProtocol?
    var dataModel: MainViewModelDataSource
    var isLoading: Bool = true
    var networkService: NetworkManager = NetworkManager()
    private var listState:Bool?{
        didSet{
            listBind?(listState)
        }
    }
    private var sliderState:Bool?{
        didSet{
            sliderBind?(sliderState)
        }
    }
    var sliderBind: ((Bool?)->Void)?
    var listBind: ((Bool?)->Void)?
    init() {
        isLoading = true
        networkService = NetworkManager()
        dataModel = MainViewModelDataSource()
        fetchListMovies()
        fetchSliderMovies()

    }
    func indicatorActivity(){
        isLoading ? viewController!.startActivity() : viewController!.stopActivity()
    }
    func moviesCount() -> Int {
        return dataModel.movieList.count
    }

    func checkAndHandleIfPaginationRequired(at row: Int) {
        if (row+1 == dataModel.movieList.count) && (dataModel.currentPageNumber != dataModel.totalPages){
            print("need to pagination")
            self.isLoading = true
            self.indicatorActivity()
            fetchNextPage()
        }
    }
    func addMovieInfoModelToMovieList(_ modelList: [MovieInfoModel]) {
        for movieInfoModel in modelList {
            dataModel.movieList.append(movieInfoModel)
        }
    }

    func updateLastFetchedPageNumber(_ nowPlayingModel: MoviesResponseModel) {
        dataModel.currentPageNumber = nowPlayingModel.page
        dataModel.totalPages = nowPlayingModel.totalPages
        print("\(dataModel.currentPageNumber) out of \(dataModel.totalPages)")
    }

    func handlePagination() {
        if !isLoading && dataModel.currentPageNumber != 0{
            isLoading = true
            indicatorActivity()
            fetchNextPage()

        }
    }
    func fetchNextPage() {
        let url = Domain.baseURL+APIEndpoint.upcomingMoviePath
        networkService.fetchFromAPI(page: dataModel.currentPageNumber+1, urlString: url) { MoviesResponseModel in

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                guard let responseModel = MoviesResponseModel else {
                    return
                }
                for movie in responseModel.results{
                    self.dataModel.movieList.append(movie)
                }
                self.dataModel.currentPageNumber = responseModel.page
                self.dataModel.totalPages = responseModel.totalPages
                self.viewController?.updateView()
                self.isLoading = false
                self.indicatorActivity()

            }
        }
    }
    func handleRefreshControl() {
        self.isLoading = true
        self.indicatorActivity()
        self.dataModel.movieList = []
        self.dataModel.currentPageNumber = 1
        self.dataModel.totalPages = 100
        fetchListMovies()
        viewController?.updateView()
        viewController?.stopRefresh()
    }

    func fetchListMovies() {
        let url = Domain.baseURL + APIEndpoint.upcomingMoviePath
        networkService.fetchFromAPI(page: dataModel.currentPageNumber, urlString: url) { movieResp in

            if movieResp == nil{
                debugPrint("We cannot fetch movie at this time.")
            }else{

                self.dataModel.movieList = movieResp!.results
                self.dataModel.totalPages = movieResp!.totalPages
                self.isLoading = false
                self.indicatorActivity()
                self.listState = true
            }

        }
    }

    func fetchSliderMovies(){

        let urlString = "\(Domain.baseURL)\(APIEndpoint.nowPlayingMoviePath)"
        networkService.fetchFromAPI(page: 1, urlString: urlString) { resp in

            self.dataModel.sliderMovieList = resp!.results
            self.sliderState = true
            self.isLoading = false
            self.indicatorActivity()

        }
    }

    func movieInfoModel(at index: Int) -> MovieInfoModel? {
        return dataModel.movieList[index]
    }


}


