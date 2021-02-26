//
//  ViewAllVC.swift
//  BookStore
//
//  Created by adol kazmy on 25/02/2021.
//

import UIKit
import RealmSwift

class ViewAllVC : UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.delegate = self ; collectionView.dataSource = self
            collectionView.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    
     //variables:
    var bookObj : BookObject?
    var books : Results<BookObject>?
    let realm = try! Realm()
    var selectedBook : BookObject?

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          loadBooks()

             }


    func loadBooks() {
        books  = realm.objects(BookObject.self)
        collectionView.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BookVC {
            destinationVC.selectedBook = selectedBook
        }
//        if let destinationVC2 = segue.destination as? SearchRate {
//            destinationVC2.delegate = self
//            print("Im Delegate")
//        }
    }

    
}
extension ViewAllVC :  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
        cell.configureCell(book: books![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedBook = books![indexPath.row]
        performSegue(withIdentifier: "toBook", sender: self)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath ) -> CGSize {
  
        
        let width = collectionView.frame.size.width / 2.8
        let height = collectionView.frame.size.width - 50

        return CGSize(width: width , height: height)
    }

  }


