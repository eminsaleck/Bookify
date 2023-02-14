//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 05.02.2023.
//

import RealmSwift
import Foundation

public class CategoryListObject: Object {
    @objc dynamic var id = UUID().uuidString
    
    @objc public dynamic var listName: String = ""
    @objc public dynamic var displayName: String = ""
    @objc public dynamic var listNameEncoded: String = ""
    @objc public dynamic var oldestPublishedDate: String = ""
    @objc public dynamic var newestPublishedDate: String = ""
    @objc public dynamic var updated: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class CategoryResponseObject: Object {
    @objc public dynamic var id = UUID().uuidString
    @objc public dynamic var status: String = ""
    @objc public dynamic var copyright: String = ""
    @objc public dynamic var numResults: Int = 0
    public let results = List<CategoryListObject>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
