//
//  MovieImageView.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 3.04.2022.
//

import UIKit
import Foundation

class MovieImageView: UIView {
    private var movieModel: MovieInfoModel

    init(frame: CGRect, movieModel: MovieInfoModel) {
        self.movieModel = movieModel
        super.init(frame: frame)
        self.movieImage.isHidden = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        if let url = URL(string: Domain.imageURL+movieModel.backdropPath!) {
            imageView.sd_setImage(with: url, completed: nil)
        }
        return imageView
    }()

}
