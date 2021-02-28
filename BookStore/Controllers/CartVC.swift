//
//  CartVC.swift
//  BookStore
//
//  Created by adol kazmy on 27/02/2021.
//

import UIKit
import RealmSwift
import Kingfisher

class CartVC: UIViewController {
    
    //outlets:
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self ; tableView.dataSource = self
            tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "cell")
        }
    }


    var selectedBook: BookObject?
    var books : [BookObject]?
    var booksSearch : Results<BookObject>?
    var copyBook : Int = 1
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksSearch = realm.objects(BookObject.self).filter("added = true")
        tableView.reloadData()
        calculatePrice()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("reloadCart"), object: nil)
    }
    
    @objc func reloadData() {

        booksSearch = nil
        tableView.reloadData()
        loadCart()

    }
    
    
    func calculatePrice() {
        var pCost : Int = 0
        for one in booksSearch! {
            pCost = pCost + (one.price * one.numCopy ?? 0)
        }
        priceLbl.text = String(pCost) + "ريال"
        shippingLbl.text = String(booksSearch!.count * 3) + "ريال"
        totalLbl.text = String(pCost + booksSearch!.count * 3) + "ريال"
        
    }
    

    
    func loadCart() {
        booksSearch = nil
        priceLbl.text = String("0") + "ريال"
        shippingLbl.text = String("0") + "ريال"
        totalLbl.text = String("0") + "ريال"
        tableView.reloadData()
        booksSearch = realm.objects(BookObject.self).filter("added = true")
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? InvoiceVC {
            destinationVC.books = booksSearch
        }
    }
    
    @IBAction func buyPressed(_ sender: Any) {

        let alert = UIAlertController(title: "شكراً لك", message: "تمت عملية الشراء بنجاح، هل تريد ارفاق فاتورة الشراء", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ارفاق الفاتورة", style: .default) { (action) in
            self.performSegue(withIdentifier: "toInvoice", sender: self)
        })
        present(alert, animated: true, completion: nil)
        

    }
    
    func updateModel(at indexPath: IndexPath) {

       if let movieForDeletion = self.booksSearch?[indexPath.row] {
           do {
               try self.realm.write {
                movieForDeletion.added = false
                   loadCart()
               }
           } catch {
               print("Error deleting category, \(error)")
           }
       }
   }
    

    
    
}
extension CartVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  booksSearch?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell

        if booksSearch != nil {
            cell.configureCell(bookObject: booksSearch![indexPath.row])
        
            return cell }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "!حذف") { (action, indexPath) in
                // delete item at indexPath
            self.updateModel(at: indexPath)
            }
        return [delete]
    }
    
}
