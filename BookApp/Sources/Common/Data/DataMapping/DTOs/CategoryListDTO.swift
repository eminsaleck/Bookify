//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation


public struct CategoryListDTO: Codable {
    public let listName: String
    public let displayName: String
    public let listNameEncoded: String
    public let oldestPublishedDate: String
    public let newestPublishedDate: String
    public let updated: Updated
    
    public enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
        case updated
    }
}

public enum Updated: String, Codable {
    case monthly = "MONTHLY"
    case weekly = "WEEKLY"
}
