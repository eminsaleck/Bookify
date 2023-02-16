//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 05.02.2023.
//

import Foundation
import RealmSwift

public class BookObject: Object {
    @objc public dynamic var id = UUID().uuidString
    @objc public dynamic var rank: Int = 0
    @objc public dynamic var rankLastWeek: Int = 0
    @objc public dynamic var weeksOnList: Int = 0
    @objc public dynamic var asterisk: Int = 0
    @objc public dynamic var dagger: Int = 0
    @objc public dynamic var primaryIsbn10: String = ""
    @objc public dynamic var primaryIsbn13: String = ""
    @objc public dynamic var publisher: String = ""
    @objc public dynamic var descriptions: String = ""
    @objc public dynamic var price: String = ""
    @objc public dynamic var title: String = ""
    @objc public dynamic var author: String = ""
    @objc public dynamic var contributor: String = ""
    @objc public dynamic var contributorNote: String = ""
    @objc public dynamic var bookImage: String = ""
    @objc public dynamic var bookImageWidth: Int = 0
    @objc public dynamic var bookImageHeight: Int = 0
    @objc public dynamic var amazonProductURL: String = ""
    @objc public dynamic var ageGroup: String = ""
    @objc public dynamic var bookReviewLink: String = ""
    @objc public dynamic var firstChapterLink: String = ""
    @objc public dynamic var sundayReviewLink: String = ""
    @objc public dynamic var articleChapterLink: String = ""
    public let isbns = List<IsbnObject>()
    public let buyLinks = List<BuyLinkObject>()
    @objc public dynamic var bookURI: String = ""
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class IsbnObject: Object {
    @objc public dynamic var id = UUID().uuidString
    @objc public dynamic var isbn10: String = ""
    @objc public dynamic var isbn13: String = ""
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class BuyLinkObject: Object {
    @objc public dynamic var id = UUID().uuidString
    @objc public dynamic var  name: String = ""
    @objc public dynamic var  url: String = ""
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class CategoryBookObject: Object {
    @objc public dynamic var id = UUID().uuidString
    @objc public dynamic var listName: String = ""
    @objc public dynamic var listNameEncoded: String = ""
    @objc public dynamic var bestsellersDate: String = ""
    @objc public dynamic var publishedDate: String = ""
    @objc public dynamic var publishedDateDescription: String = ""
    @objc public dynamic var nextPublishedDate: String = ""
    @objc public dynamic var previousPublishedDate: String = ""
    @objc public dynamic var displayName: String = ""
    @objc public dynamic var normalListEndsAt: Int = 0
    @objc public dynamic var updated: String = ""
    public dynamic var books = List<BookObject>()
    public dynamic var corrections = List<String>()
    public override static func primaryKey() -> String? {
        return "id"
    }
}
