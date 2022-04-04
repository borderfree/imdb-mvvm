//
//  MovieDetailBottomView.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 3.04.2022.
//

import UIKit

class MovieDetailBottomView: UIView {

    private var movieModel: MovieInfoModel


    init(frame: CGRect, movieModel: MovieInfoModel) {
        self.movieModel = movieModel
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.overviewTitle.isHidden = false
        self.overviewTextView.isHidden = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private lazy var overviewTitle: UIView = {
        let titleView = UITextView(frame: .zero)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.isScrollEnabled = false
        titleView.isEditable = false
        titleView.text = "\(movieModel.title) (\(movieModel.year()))"
        titleView.textColor = .appTextBlack
        titleView.font = UIFont.bold(size: 20)

        self.addSubview(titleView)
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        return titleView
    }()

    private lazy var overviewTextView : UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.text = movieModel.overview
        textView.textColor = .appTextBlack
        textView.font = UIFont.regular(size: 15)


        self.addSubview(textView)
        textView.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true

        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        return textView
    }()

}
