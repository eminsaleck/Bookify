//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//


import Foundation


public struct CategoryList: Hashable {
    
    public init(listName: String,
                displayName: String,
                listNameEncoded: String,
                oldestPublishedDate: String,
                newestPublishedDate: String,
                updated: Updated)
    {
        self.listName = listName
        self.displayName = displayName
        self.listNameEncoded = listNameEncoded
        self.oldestPublishedDate = oldestPublishedDate
        self.newestPublishedDate = newestPublishedDate
        self.updated = updated
    }
    
    public let listName: String
    public let displayName: String
    public let listNameEncoded: String
    public let oldestPublishedDate: String
    public let newestPublishedDate: String
    public let updated: Updated
}
