//
//  MovieTableViewCell.swift
//  MobiliumTask
//
//  Created by Fetih Tunay Yetişir on 30.03.2022.
//

import UIKit
import SDWebImage
class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseOfDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    static var identifier : String{
        return String(describing: Self.self)
    }
    static let nib = UINib(nibName: identifier, bundle: nil)

    override func layoutSubviews() {
        super.layoutSubviews()
        self.movieNameLabel.textColor = .appTextBlack
        self.movieNameLabel.font = UIFont.bold(size: 15)
        self.overViewLabel.textColor = .appDarkGray
        self.overViewLabel.font = UIFont.medium(size: 13)
        self.releaseOfDateLabel.textColor = .appDarkGray
        self.releaseOfDateLabel.font = UIFont.medium(size: 12)
        self.releaseOfDateLabel.textAlignment = .left
        self.movieImageView.layer.cornerRadius = 5
        self.movieImageView.contentMode = .scaleAspectFill

    }

    var movieItem: MovieInfoModel? {

        didSet {

            if let movie = movieItem {

                self.movieNameLabel.text = "\(movie.title) (\(movie.year()))"

                self.overViewLabel.text = movie.overview 
                guard let imageURL = URL(string: Domain.imageURL+movie.posterPath) else{ return
                }

                self.releaseOfDateLabel.text = movie.dateFormating()
                self.movieImageView.sd_setImage(with: imageURL, completed: nil)

            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
