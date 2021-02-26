//
//  OffersCell.swift
//  Store Project
//
//  Created by adol kazmy on 23/06/2020.
//  Copyright © 2020 Adel Kazme. All rights reserved.
//

import UIKit
import Kingfisher
import Realm

class OffersCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bookImg: UIImageView!
    

    func configureCell(book: BookObject) {
        titleLbl.text = book.title
        if let url = URL(string: book.bookImg){
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [.transition(.fade(0.3))]
        bookImg.kf.setImage(with: url , placeholder: placeholder , options: options )
        }
        priceLbl.text = book.price.description + "SR"
        authorLbl.text = book.author
        
        
        
    }
    
}
