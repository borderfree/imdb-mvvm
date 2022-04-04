//
//  MainViewProtocol.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 4.04.2022.
//

import Foundation
protocol ViewProtocol:AnyObject {
    func updateView()
    func stopRefresh()
    func setupView()
    func startActivity()
    func stopActivity()

}
protocol MainViewModelProtocol:AnyObject{
    var isLoading:Bool { get set }

    var networkService : NetworkManager { get }
    func moviesCount() -> Int
    func checkAndHandleIfPaginationRequired(at row: Int)
    func fetchListMovies()
    func handlePagination()
    func fetchNextPage()
}

