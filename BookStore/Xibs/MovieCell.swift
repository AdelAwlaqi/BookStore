//
//  MovieCell.swift
//  MovieApp
//
//  Created by adol kazmy on 18/02/2021.
//

import UIKit
import Kingfisher
import RealmSwift

class MovieCell: UITableViewCell {
    
    //Outlets :
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var movieTypeLbl: UILabel!
    @IBOutlet weak var movieRateLbl: UILabel!

   //Variables :
    var bookObj : BookObject?
    var books : [BookObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configureCell(bookObject: BookObject) {
//        movieLbl.text = movieObject.movieName
//        if let url = URL(string: movieObject.movieImgLink){
//            let placeholder = UIImage(named: "inside")
//            let options : KingfisherOptionsInfo = [.transition(.fade(0.3))]
//        movieImg.kf.setImage(with: url , placeholder: placeholder , options: options )
//        }
////        cell.movieImg.image = movies[indexPath.row].movieImgName
//        movieTypeLbl.text = "\(movieObject.movieType1) \(movieObject.movieType2 ) \(movieObject.movieType3)"
//        movieRateLbl.text = String(movieObject.movieRate )
//
//
    }

}
