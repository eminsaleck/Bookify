//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 05.02.2023.
//

import RealmSwift
import Foundation

class CategoryListObject: Object {
    @objc dynamic var listName: String = ""
    @objc dynamic var displayName: String = ""
    @objc dynamic var listNameEncoded: String = ""
    @objc dynamic var oldestPublishedDate: String = ""
    @objc dynamic var newestPublishedDate: String = ""
    @objc dynamic var updated: String = ""
}

class CategoryResponseObject: Object {
    @objc dynamic var status: String = ""
    @objc dynamic var copyright: String = ""
    @objc dynamic var numResults: Int = 0
    let results = List<CategoryListObject>()
}
