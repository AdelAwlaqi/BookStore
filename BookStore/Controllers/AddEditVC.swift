//
//  AddEditMovie.swift
//  MovieApp
//
//  Created by adol kazmy on 19/02/2021.
//

import UIKit
import RealmSwift


class AddEditVC : UIViewController {
    
    //Outlets:
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var authorTxt: UITextField!
    @IBOutlet weak var bookIDTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var quantityTxt: UITextField!
    @IBOutlet weak var bookImgLinkTxt: UITextField!
    @IBOutlet weak var uploadEditButton: UIButton!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    //variables:
    let realm = try! Realm()
    let newBook = BookObject()
    var selectedBook : BookObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.isEnabled = false
        editingMode()
    }
    
    @IBAction func uploadPressed(_ sender: Any) {
        
        newBook.title = titleTxt.text!
        newBook.author = authorTxt.text!
        newBook.bookImg = bookImgLinkTxt.text!
        //to check if these text fields do not have any letters:
        let letters = CharacterSet.letters
        if bookIDTxt.text!.rangeOfCharacter(from: letters) == nil ||
            priceTxt.text!.rangeOfCharacter(from: letters) == nil ||
            quantityTxt.text!.rangeOfCharacter(from: letters) == nil   {
            newBook.bookID = Int(bookIDTxt.text!) ?? 1
            newBook.price = Int(priceTxt.text!) ?? 1
            newBook.quantity = Int(quantityTxt.text!) ?? 1
            newBook.date = Date()
    }
        save(book: newBook)
        navigationController?.popToRootViewController(animated: true)

        if let edited = selectedBook {
            delete(book: edited)
        }
        NotificationCenter.default.post(name: NSNotification.Name("reloadData"), object: nil, userInfo: nil)
    }
    
    func save(book: BookObject) {
        do {
            try realm.write {
                realm.add(book)
            }
        } catch {
            print("Error saving book \(error)")
        }
    }
    
    func delete(book: BookObject) {
        do {
            try realm.write {
                realm.delete(book)
            }
        } catch {
            print("Error deleting book \(error)")
        }
    }
    
    func editingMode() {
        if selectedBook != nil {
            deleteButton.isEnabled = true
            titleTxt.text = selectedBook?.title
            authorTxt.text = selectedBook?.author
            priceTxt.text = selectedBook?.price.description
            bookIDTxt.text = selectedBook?.bookID.description
            quantityTxt.text = selectedBook?.quantity.description
            bookImgLinkTxt.text = selectedBook?.bookImg
//            selectedBook?.date = Date()
            uploadEditButton.setTitle("تعديل", for: .normal)
            uploadEditButton.backgroundColor = #colorLiteral(red: 0, green: 0.5452948213, blue: 0.5925067663, alpha: 1)
              }
        }
    
    
    @IBAction func deletePressed(_ sender: Any) {
        let alert = UIAlertController(title: "حذف الكتاب؟", message: "هل أنت متأكد من حذف الكتاب؟", preferredStyle: .alert)
        let action = UIAlertAction(title: "نعم", style: .destructive) { (action) in
            self.delete(book: self.selectedBook!)
            self.navigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("reloadData"), object: nil, userInfo: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
