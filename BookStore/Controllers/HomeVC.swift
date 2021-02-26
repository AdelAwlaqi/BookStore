//
//  HomeVC.swift
//  BookStore
//
//  Created by adol kazmy on 24/02/2021.
//

import UIKit
import RealmSwift


class HomeVC : UIViewController {
    
    //variables:
    var selectedBook : BookObject?
    var books : Results<BookObject>?
    let realm = try! Realm()

    
    @IBOutlet weak var collectionView1: UICollectionView! {
        didSet {
            
            collectionView1.delegate = self ;collectionView1.dataSource = self
            collectionView1.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var collectionView2: UICollectionView! {
        didSet {
            
            collectionView2.delegate = self ;collectionView2.dataSource = self
            collectionView2.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var collectionView3: UICollectionView! {
        didSet {
            
            collectionView3.delegate = self ;collectionView3.dataSource = self
            collectionView3.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }
    
    func loadMovies() {
        books  = realm.objects(BookObject.self)
        collectionView1.reloadData()
        
    }
    
    @IBAction func viewAllPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAll", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BookVC {
            destinationVC.selectedBook = selectedBook
        }
    }
    
}
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            return books!.count }
        if collectionView.tag == 2 {
            return 2 }
        if collectionView.tag == 3 {
            return 2 }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
            cell.configureCell(book: books![indexPath.row])
            print(books?.count)
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
            return cell
        }
        if collectionView.tag == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath ) -> CGSize {
        
        
        if collectionView.tag == 1 || collectionView.tag == 2 || collectionView.tag == 3 {
            
            let width = collectionView.frame.size.height / 1.7
            let height = collectionView.frame.size.height
            
            return CGSize(width: width , height: height)
            
        }
        return CGSize(width: 50 , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedBook = books![indexPath.row]
        performSegue(withIdentifier: "toBook", sender: self)
    }
    
    
}
