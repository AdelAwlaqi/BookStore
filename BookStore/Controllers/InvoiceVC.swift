//
//  InvoiceVC.swift
//  BookStore
//
//  Created by adol kazmy on 28/02/2021.
//

import UIKit
import RealmSwift


class InvoiceVC : UIViewController {
    //Outlets:
    var books : Results<BookObject>?
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self ; tableView.dataSource = self
            tableView.register(UINib(nibName: "InvoiceCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = realm.objects(BookObject.self).filter("added = true")
        

    }
    
    func decresebook( book: BookObject) {

           do {
               try self.realm.write {
                book.quantity = book.quantity - book.numCopy
                book.added = false
                loadCart()
               }
           } catch {
               print("Error deleting category, \(error)")
           }

   }
    
    func loadCart() {
        tableView.reloadData()
        books = realm.objects(BookObject.self).filter("added = true")
        tableView.reloadData()
        
    }
    
    
    @IBAction func dismissPressed(_ sender: Any) {
        
            for b in books! {
                decresebook(book: b)
            }
            loadCart()
        NotificationCenter.default.post(name: NSNotification.Name("reloadCart"), object: nil, userInfo: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func takeScreenshot(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        var imagesToShare = [UIImage]()
        imagesToShare.append(image!)

        let activityViewController = UIActivityViewController(activityItems: imagesToShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    
    
}
extension InvoiceVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvoiceCell
        cell.configureCell(bookObject: books![indexPath.row])
        return cell
    }
    
    
    
    
}
