//
//  BookVC.swift
//  BookStore
//
//  Created by adol kazmy on 26/02/2021.
//

import UIKit
import Kingfisher
import RealmSwift

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
    let realm = try! Realm()
    
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
        checkQuantity()
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AddEditVC {
            destinationVC.selectedBook = selectedBook
        }
        if let destinationVC2 = segue.destination as? CartVC {
            do {
                try realm.write {
                    selectedBook?.numCopy = counter
                    selectedBook?.added = true
                }
            } catch {
                print("Error saving book \(error)")
            }
           
        }
    }
    
    @IBAction func editPressed(_ sender: Any) {
        performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    
    func checkQuantity() {
        
        if selectedBook!.quantity <= counter || counter == 1 {
            decreaseBtn.isEnabled = false
        } else {decreaseBtn.isEnabled = true}
        
         if counter >= selectedBook!.quantity {
            increaseBtn.isEnabled = false
            decreaseBtn.isEnabled = true
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

        do {
            try realm.write {
                selectedBook?.numCopy = counter
                selectedBook?.added = true
            }
        } catch {
            print("Error saving book \(error)")
        }
        
        let alert = UIAlertController(title: "تم الاضافة بنجاح", message: "هل تريد انهاء عملية الشراء", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "الانتقال للسلة", style: .default) { (action) in
            self.performSegue(withIdentifier: "toCart", sender: self)
        })
        alert.addAction(UIAlertAction(title: "متابعة التسوق", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }
}
