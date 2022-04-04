//
//  ViewController.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 29.03.2022.
//

import UIKit
import ImageSlideshow
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewProtocol {

    @IBOutlet weak var sliderImageView: ImageSlideshow!
    @IBOutlet weak var sliderMovieTitle: UILabel!
    @IBOutlet weak var sliderMovieOverview:UILabel!
    @IBOutlet weak var tableView: UITableView!

    var sliderTitle = ""
    var sliderOverview = ""

    var refreshControl = UIRefreshControl()
    var activityIndicator: UIActivityIndicatorView?

    var viewModel : MainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshControlConnection()
        setupTableView()
        viewModel = MainViewModel()
        viewModel?.viewController = self
        viewModel?.listBind = { [unowned self] data in
            self.updateView()
        }
        viewModel?.sliderBind = { [unowned self] data in
            finalSlider()
        }

        refreshControlHandler()
        startActivity()
    }

    private var lastContentOffset: CGFloat = 0

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y

        print(offset)

        if(offset > 150){

            UIView.animate(withDuration: 0.5) {
                self.sliderImageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 0)

            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.sliderImageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 150 - offset)

            }
        }
        let rect = CGRect(x: 0, y: self.sliderImageView.frame.maxY, width: self.sliderImageView.bounds.size.width, height:(self.view.bounds.size.height - (self.sliderImageView.frame.maxY)))
        self.tableView.frame = rect
        self.view.layoutIfNeeded()


    }
}


extension MainViewController:ImageSlideshowDelegate{
    func setSlider(){

        var imageSource = [SDWebImageSource]()
        let list = viewModel!.dataModel.sliderMovieList
        for i in list{

            imageSource.append((SDWebImageSource(urlString: Domain.imageURL + i.backdropPath!) ?? SDWebImageSource(urlString: ""))!)

        }
        sliderImageView.setImageInputs(imageSource)
        
    }

    func sliderGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSlider))
        sliderImageView.addGestureRecognizer(gestureRecognizer)
    }
    func finalSlider(){
        setSlider()
        sliderGesture()
        sliderConfig()


    }



    @objc func didTapSlider(){
        let selectedMovie = self.viewModel!.dataModel.sliderMovieList[self.sliderImageView.currentPage]
        let vc = DetailViewController(selectedMovie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func sliderConfig(){

        sliderImageView.contentScaleMode = .scaleAspectFill
        sliderImageView.activityIndicator = DefaultActivityIndicator(style: .medium, color: .black)

    }
}

extension MainViewController{
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    func refreshControlHandler(){
        refreshControl.addTarget(self, action: #selector(viewModelToRC), for: .valueChanged)
    }

    @objc func viewModelToRC(){
        viewModel!.handleRefreshControl()
    }
}

extension MainViewController{

    func stopRefresh() {
        refreshControl.endRefreshing()
    }

    func startActivity() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator?.backgroundColor = .appYellow
        activityIndicator?.layer.cornerRadius = 10
        activityIndicator?.style = .large
        activityIndicator?.color = .appTextBlack
        activityIndicator?.center = self.view.center
        self.view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
    }

    func stopActivity(){
        if (activityIndicator != nil){
            activityIndicator?.stopAnimating()
        }
    }
}

extension MainViewController{
    func refreshControlConnection(){
        tableView.refreshControl = refreshControl
    }
    func updateView() {
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.dataModel.movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            fatalError("Cell is not found")
        }
        cell.movieItem = viewModel!.dataModel.movieList[indexPath.row]
        viewModel?.checkAndHandleIfPaginationRequired(at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let movieModel = viewModel?.movieInfoModel(at: indexPath.row){
            print(movieModel)
            let movieDetailsVC = DetailViewController(movieModel)
            navigationController?.pushViewController(movieDetailsVC, animated: true)

        }
    }

}



extension MainViewController{
    func setupView() {
        self.navigationController?.navigationBar.isHidden = true
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
