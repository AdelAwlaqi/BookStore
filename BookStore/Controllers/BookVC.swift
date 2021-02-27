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
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var decreaseBtn: UIButton!
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var counterLbl: UILabel!
    
    var selectedBook: BookObject?
    var counter = 1
    
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
            quantityLbl.text = "\(notEmpty.quantity) نسخة"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddEditVC {
            destinationVC.selectedBook = selectedBook
        }
        if let destinationVC2 = segue.destination as? CartVC {
            destinationVC2.selectedBook = selectedBook
            destinationVC2.num = counter
        }
    }
    
    @IBAction func editPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    func checkQuantity() {
        if counter == 1 {
            decreaseBtn.isEnabled = false
        } else {decreaseBtn.isEnabled = true}
         if counter == 10 {
            increaseBtn.isEnabled = false
        } else {
            increaseBtn.isEnabled = true
        }
    }
    
    @IBAction func decreasePressed(_ sender: Any) {
        counter -= 1
        counterLbl.text = counter.description
        checkQuantity()
    }
    @IBAction func increasePressed(_ sender: Any) {
       
        counter += 1
        counterLbl.text = counter.description
        checkQuantity()
    }
    

    @IBAction func addPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "toCart", sender: self)
    }
    
    
}
