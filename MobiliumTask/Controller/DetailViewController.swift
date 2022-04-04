//
//  DetailViewController.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 29.03.2022.
//


import UIKit

class DetailViewController: UIViewController {

    //MARK: -Internal Properties



    private var viewModel: DetailViewModel

    init(_ movieInfoModel: MovieInfoModel) {
        viewModel = DetailViewModel(movieInfoModel)
        super.init(nibName: nil, bundle: nil)

        viewModel.viewController = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        movieImageView.isHidden = false
        movieDetailMidView.isHidden = false
        movieDetailBottom.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        setTitle()
    }

    
    func setTitle(){
        title = viewModel.movieTitle()
        
    }

    private lazy var movieImageView: MovieImageView = {
        let movieView = MovieImageView(frame: .zero, movieModel: viewModel.movieInfoModel())
        movieView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieView)


        movieView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        movieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        movieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        movieView.heightAnchor.constraint(equalToConstant: 240).isActive = true

        return movieView
    }()
    private lazy var movieDetailMidView : MovieDetailMidView = {
        let midView = MovieDetailMidView(frame: .zero, movieModel: viewModel.movieInfoModel())
        midView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(midView)

        midView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10).isActive = true
        midView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true


        midView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return midView
    }()

    private lazy var movieDetailBottom:MovieDetailBottomView = {
        let bottomView = MovieDetailBottomView(frame: .zero, movieModel: viewModel.movieInfoModel())
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)

        bottomView.topAnchor.constraint(equalTo: movieDetailMidView.bottomAnchor, constant: 10).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true


        return bottomView
    }()

}

