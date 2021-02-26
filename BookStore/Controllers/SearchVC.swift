//
//  SearchVC.swift
//  MovieApp
//
//  Created by adol kazmy on 18/02/2021.
//

import UIKit
import RealmSwift


class SearchVC : UIViewController  {
    
    
    // outlets:
    @IBOutlet weak var searchName: UISearchBar!
    @IBOutlet weak var searchID: UISearchBar!
    @IBOutlet weak var searchAuthor: UISearchBar!
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
//        tableView.separatorStyle = .none
//        tableView.reloadData()

             }


    func loadBooks() {
        books  = realm.objects(BookObject.self)
        collectionView.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destinationVC = segue.destination as? SearchType {
//            destinationVC.delegate = self
//        }
//        if let destinationVC2 = segue.destination as? SearchRate {
//            destinationVC2.delegate = self
//            print("Im Delegate")
//        }
    }

    
}
extension SearchVC : UISearchBarDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OffersCell
        cell.configureCell(book: books![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toBook", sender: self)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.tag == 1 {
        //loadBooks()
        books = books?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
            collectionView.reloadData()
        }
        if searchBar.tag == 2 {
        loadBooks()
        books = books?.filter("bookID CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
            collectionView.reloadData()
        }
        if searchBar.tag == 3 {
        books = books?.filter("author CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
            collectionView.reloadData()
        }
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 && searchBar.tag == 1 || searchBar.tag == 2 && searchBar.text?.count == 0 || searchBar.tag == 3 && searchBar.text?.count == 0 {
            
            loadBooks()
            DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            }

        } else if searchBar.text!.count > 0 {
            if searchBar.tag == 1 {
            //loadMovies()
            books = books?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
                collectionView.reloadData()
            }
            if searchBar.tag == 2 {
            loadBooks()
            books = books?.filter("bookID CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
                collectionView.reloadData()
            }
            if searchBar.tag == 3 {
            books = books?.filter("author CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
                collectionView.reloadData()
            }
        }
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath ) -> CGSize {
  
        
        let width = collectionView.frame.size.width / 2.8
        let height = collectionView.frame.size.width - 50

        return CGSize(width: width , height: height)
    }

  }

