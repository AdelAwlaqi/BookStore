//
//  BookVC.swift
//  BookStore
//
//  Created by adol kazmy on 26/02/2021.
//

import UIKit
import Kingfisher

class BookVC : UIViewController {
    
    @IBOutlet weak var bookImg: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    var selectedBook: BookObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let notEmpty = selectedBook {
        titleLbl.text = notEmpty.title
        if let url = URL(string: notEmpty.bookImg){
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [.transition(.fade(0.3))]
        bookImg.kf.setImage(with: url , placeholder: placeholder , options: options )
        }
        priceLbl.text = notEmpty.price.description + " ريال "
        authorLbl.text = notEmpty.author
        
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddEditVC {
            destinationVC.selectedBook = selectedBook
        }
    }
    
    @IBAction func editPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEdit", sender: self)
    }
    
}
