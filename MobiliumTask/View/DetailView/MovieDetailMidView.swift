//
//  MovieDetailMidView.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 3.04.2022.
//

import UIKit
import SafariServices
class MovieDetailMidView: UIView {

    private var movieModel: MovieInfoModel
    private var networkManager: NetworkManager


    init(frame: CGRect, movieModel: MovieInfoModel) {
        self.movieModel = movieModel
        networkManager = NetworkManager()
        super.init(frame: frame)
        addViewsToStackView()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @objc func toIMDB(){
        let url = Domain.baseURL+APIEndpoint.movie+String(movieModel.id)+"?api_key="+APIKey.key
        print(url)
        networkManager.fetchIMDBID(url: url) { (model) in
            if let id = model?.imdbId{
                let imdbURL = "https://www.imdb.com/title/"+id
                if UIApplication.shared.canOpenURL(URL(string: imdbURL)!) {
                     UIApplication.shared.open(URL(string: imdbURL)!, options: [:], completionHandler: nil)
                }
            }
        }
    }
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8


        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true

        return stackView
    }()

    func addViewsToStackView(){
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(imdbButton)
        stackView.addArrangedSubview(rateIcon)
        stackView.addArrangedSubview(rateAverage)
        stackView.addArrangedSubview(seperatorView)
        stackView.addArrangedSubview(dateLabel)

    }
    private lazy var imdbButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "IMDB Logo"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.addTarget(self, action: #selector(toIMDB), for: .touchUpInside)
        return button
    }()
    private lazy var rateIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Rate Icon")
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true


        return imageView
    }()

    private lazy var rateAverage: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        let attrs1 = [NSAttributedString.Key.font : UIFont.medium(size: 13), NSAttributedString.Key.foregroundColor : UIColor.appTextBlack]

        let attrs2 = [NSAttributedString.Key.font : UIFont.medium(size: 13), NSAttributedString.Key.foregroundColor : UIColor.appDarkGray]


        let attributedString1 = NSMutableAttributedString(string:String(movieModel.voteAverage), attributes:attrs1)

        let attributedString2 = NSMutableAttributedString(string:"/10", attributes:attrs2)


        attributedString1.append(attributedString2)

        label.attributedText = attributedString1
        return label
    }()

    private lazy var seperatorView : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appYellow
        view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        view.widthAnchor.constraint(equalToConstant: 5).isActive = true
        view.layer.cornerRadius = 5

        return view
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movieModel.dateFormating()
        label.textColor = .appTextBlack
        label.font = UIFont.medium(size: 13)
        return label
    }()


}
