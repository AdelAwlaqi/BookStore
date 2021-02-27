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
    var newBooks : Results<BookObject>?
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("reloadData"), object: nil)
    }
    
    @objc func reloadData() {
        books = nil
        newBooks = nil
        collectionView1.reloadData()
        collectionView2.reloadData()
        loadBooks()

    }
    
    func loadBooks() {
        books  = realm.objects(BookObject.self).sorted(byKeyPath: "title", ascending: true)
        newBooks  = realm.objects(BookObject.self).sorted(byKeyPath: "date", ascending: false)
        collectionView1.reloadData()
        collectionView2.reloadData()
        
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
            return newBooks!.count }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
            cell.configureCell(book: books![indexPath.row])
            return cell
        }
        if collectionView.tag == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
            cell.configureCell(book: newBooks![indexPath.row])
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
        if collectionView.tag == 1 {
            selectedBook = books![indexPath.row] }
        if collectionView.tag == 2 {
            selectedBook = newBooks![indexPath.row] }
        performSegue(withIdentifier: "toBook", sender: self)
    }
    
    
}
