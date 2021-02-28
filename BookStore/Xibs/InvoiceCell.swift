//
//  InvoiceCell.swift
//  BookStore
//
//  Created by adol kazmy on 28/02/2021.
//

import UIKit

class InvoiceCell: UITableViewCell {

   
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    
    func configureCell(bookObject: BookObject) {
        bookName.text = bookObject.title
        quantity.text = bookObject.numCopy.description
        price.text = String(bookObject.price * bookObject.numCopy)

    }
    
    
}
