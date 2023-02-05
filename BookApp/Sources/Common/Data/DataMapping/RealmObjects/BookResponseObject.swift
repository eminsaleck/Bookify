//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 05.02.2023.
//

import Foundation
import RealmSwift

@objcMembers class BookObject: Object{
    dynamic var id = UUID().uuidString
    dynamic var rank: Int = 0
    dynamic var rankLastWeek: Int = 0
    dynamic var weeksOnList: Int = 0
    dynamic var asterisk: Int = 0
    dynamic var dagger: Int = 0
    dynamic var primaryIsbn10: String = ""
    dynamic var primaryIsbn13: String = ""
    dynamic var publisher: String = ""
    dynamic var descriptions: String = ""
    dynamic var price: String = ""
    dynamic var title: String = ""
    dynamic var author: String = ""
    dynamic var contributor: String = ""
    dynamic var contributorNote: String = ""
    dynamic var bookImage: String = ""
    dynamic var bookImageWidth: Int = 0
    dynamic var bookImageHeight: Int = 0
    dynamic var amazonProductURL: String = ""
    dynamic var ageGroup: String = ""
    dynamic var bookReviewLink: String = ""
    dynamic var firstChapterLink: String = ""
    dynamic var sundayReviewLink: String = ""
    dynamic var articleChapterLink: String = ""
    let isbns = List<IsbnObject>()
    let buyLinks = List<BuyLinkObject>()
    dynamic var bookURI: String = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers class IsbnObject: Object{
    dynamic var id = UUID().uuidString
    dynamic var isbn10: String = ""
    dynamic var isbn13: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers class BuyLinkObject: Object {
    dynamic var id = UUID().uuidString
    dynamic var  name: String = ""
    dynamic var  url: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

@objcMembers class CategoryBookObject: Object {
    dynamic var id = UUID().uuidString
    dynamic var listName: String = ""
    dynamic var listNameEncoded: String = ""
    dynamic var bestsellersDate: String = ""
    dynamic var publishedDate: String = ""
    dynamic var publishedDateDescription: String = ""
    dynamic var nextPublishedDate: String = ""
    dynamic var previousPublishedDate: String = ""
    dynamic var displayName: String = ""
    dynamic var normalListEndsAt: Int = 0
    dynamic var updated: String = ""
    dynamic var books = List<BookObject>()
    dynamic var corrections = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
