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
    @IBOutlet weak var bookImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var copyLbl: UILabel!

   //Variables :
    var bookObj : BookObject?
    var books : [BookObject] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configureCell(bookObject: BookObject) {
        titleLbl.text = bookObject.title
        if let url = URL(string: bookObject.bookImg){
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [.transition(.fade(0.3))]
        bookImg.kf.setImage(with: url , placeholder: placeholder , options: options )
        }
        authorLbl.text = bookObject.author
        priceLbl.text = bookObject.price.description
        copyLbl.text = bookObject.numCopy.description


    }

}
