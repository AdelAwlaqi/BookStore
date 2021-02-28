//
//  MovieObject.swift
//  MovieApp
//
//  Created by adol kazmy on 18/02/2021.
//

import Foundation
import RealmSwift


class BookObject : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var bookID : Int = 0
    @objc dynamic var bookImg : String = ""
    @objc dynamic var author : String = ""
    @objc dynamic var price : Int = 0
    @objc dynamic var quantity : Int = 0
    @objc dynamic var date : Date?
    @objc dynamic var numCopy : Int = 0
    @objc dynamic var added : Bool = false
    

}
