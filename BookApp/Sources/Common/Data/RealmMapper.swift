//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 14.02.2023.
//

import Foundation
import RealmSwift
import Persistance

public protocol RealmMapperProtocol {
    func mapResults(object: CategoryBookObject) -> BooksResponse.CategoryBook
    func cache(booksResponse: BooksResponse)
    func mapCategoryObject(categoryObject: CategoryResponseObject) throws -> CategoryResponse
}

public final class RealmMapper: RealmMapperProtocol {
    
    public init() { }
    
    public func mapCategoryObject(categoryObject: CategoryResponseObject) throws -> CategoryResponse {
         let categoryResponse = CategoryResponse(status: categoryObject.status,
                                                 copyright: categoryObject.copyright,
                                                 numResults: categoryObject.numResults,
                                                 results: categoryObject.results.map { categoryListObject in
             CategoryList(listName: categoryListObject.listName,
                          displayName: categoryListObject.displayName,
                          listNameEncoded: categoryListObject.listNameEncoded,
                          oldestPublishedDate: categoryListObject.oldestPublishedDate,
                          newestPublishedDate: categoryListObject.newestPublishedDate,
                          updated: categoryListObject.updated)
         })
         return categoryResponse
     }
    
    public func mapResults(object: CategoryBookObject) -> BooksResponse.CategoryBook{
        let results = BooksResponse.CategoryBook(listName: object.listName,
                                                 listNameEncoded: object.listNameEncoded,
                                                 bestsellersDate: object.bestsellersDate,
                                                 publishedDate: object.publishedDate,
                                                 publishedDateDescription: object.publishedDateDescription,
                                                 nextPublishedDate: object.nextPublishedDate,
                                                 previousPublishedDate: object.previousPublishedDate,
                                                 displayName: object.previousPublishedDate,
                                                 normalListEndsAt: object.normalListEndsAt,
                                                 updated: object.updated,
                                                 corrections: object.corrections.map({ correction in
            return correction
        }),
                                                 books: mapBook(object: object.books))
        return results
    }
    
     func mapBook(object: List<BookObject>) -> [BooksResponse.CategoryBook.Book]{
        object.map { bookObject in
            return BooksResponse.CategoryBook.Book(rank: bookObject.rank,
                                                   rankLastWeek: bookObject.rankLastWeek,
                                                   weeksOnList: bookObject.weeksOnList,
                                                   asterisk: bookObject.asterisk,
                                                   dagger: bookObject.dagger,
                                                   primaryIsbn10: bookObject.primaryIsbn10,
                                                   primaryIsbn13: bookObject.primaryIsbn13,
                                                   publisher: bookObject.publisher,
                                                   description: bookObject.descriptions,
                                                   price: bookObject.price,
                                                   title: bookObject.title,
                                                   author: bookObject.author,
                                                   contributor: bookObject.contributor,
                                                   contributorNote: bookObject.contributorNote,
                                                   bookImage: bookObject.bookImage,
                                                   bookImageWidth: bookObject.bookImageWidth,
                                                   bookImageHeight: bookObject.bookImageHeight,
                                                   amazonProductURL: bookObject.amazonProductURL,
                                                   ageGroup: bookObject.ageGroup,
                                                   bookReviewLink: bookObject.bookReviewLink,
                                                   firstChapterLink: bookObject.firstChapterLink,
                                                   sundayReviewLink: bookObject.sundayReviewLink,
                                                   articleChapterLink: bookObject.articleChapterLink,
                                                   isbns: mapIsbn(object: bookObject.isbns),
                                                   buyLinks: mapLinks(object: bookObject.buyLinks),
                                                   bookURI: bookObject.bookURI)
        }
    }
    
     func mapIsbn(object: List<IsbnObject>) -> [BooksResponse.CategoryBook.Isbn]{
        object.map { isbnObject in
            return BooksResponse.CategoryBook.Isbn(isbn10: isbnObject.isbn10, isbn13: isbnObject.isbn13)
        }
    }
    
     func mapLinks(object: List<BuyLinkObject>) -> [BooksResponse.CategoryBook.BuyLink]{
        object.map { buyObject in
            return BooksResponse.CategoryBook.BuyLink(name: Name(rawValue: buyObject.name)!, url: buyObject.url)
        }
    }
    
    public func map(categoryResponse: CategoryResponse) -> CategoryResponseObject {
        let categoryResponseObject = CategoryResponseObject()
        categoryResponseObject.status = categoryResponse.status
        categoryResponseObject.copyright = categoryResponse.copyright
        categoryResponseObject.numResults = categoryResponse.numResults
        let categoryListObjects = categoryResponse.results.map { self.map(categoryList: $0) }
        categoryResponseObject.results.append(objectsIn: categoryListObjects)
        return categoryResponseObject
    }
    
    public  func map(categoryList: CategoryList) -> CategoryListObject {
        let categoryListObject = CategoryListObject()
        categoryListObject.listName = categoryList.listName
        categoryListObject.displayName = categoryList.displayName
        categoryListObject.listNameEncoded = categoryList.listNameEncoded
        categoryListObject.oldestPublishedDate = categoryList.oldestPublishedDate
        categoryListObject.newestPublishedDate = categoryList.newestPublishedDate
        categoryListObject.updated = categoryList.updated
        return categoryListObject
    }
    
    public func cache(booksResponse: BooksResponse) {
        let realm = try! Realm()
        try! realm.write {
            
            let categoryBookObject = CategoryBookObject()
            let categoryBook = booksResponse.results
            categoryBookObject.listName = categoryBook.listName
            categoryBookObject.listNameEncoded = categoryBook.listNameEncoded
            categoryBookObject.bestsellersDate = categoryBook.bestsellersDate
            categoryBookObject.publishedDate = categoryBook.publishedDate
            categoryBookObject.publishedDateDescription = categoryBook.publishedDateDescription
            categoryBookObject.nextPublishedDate = categoryBook.nextPublishedDate
            categoryBookObject.previousPublishedDate = categoryBook.previousPublishedDate
            categoryBookObject.displayName = categoryBook.displayName
            categoryBookObject.normalListEndsAt = categoryBook.normalListEndsAt
            categoryBookObject.updated = categoryBook.updated
            categoryBookObject.corrections.append(objectsIn: categoryBook.corrections)
            
            let bookObjects = categoryBook.books
                .map { book -> BookObject in
                    let bookObject = BookObject()
                    bookObject.rank = book.rank
                    bookObject.rankLastWeek = book.rankLastWeek
                    bookObject.weeksOnList = book.weeksOnList
                    bookObject.asterisk = book.asterisk
                    bookObject.dagger = book.dagger
                    bookObject.primaryIsbn10 = book.primaryIsbn10
                    bookObject.primaryIsbn13 = book.primaryIsbn13
                    bookObject.publisher = book.publisher
                    bookObject.descriptions = book.description
                    bookObject.price = book.price
                    bookObject.title = book.title
                    bookObject.author = book.author
                    bookObject.contributor = book.contributor
                    bookObject.contributorNote = book.contributorNote
                    bookObject.bookImage = book.bookImage
                    bookObject.bookImageWidth = book.bookImageWidth
                    bookObject.bookImageHeight = book.bookImageHeight
                    bookObject.amazonProductURL = book.amazonProductURL
                    bookObject.ageGroup = book.ageGroup
                    bookObject.bookReviewLink = book.bookReviewLink
                    bookObject.firstChapterLink = book.firstChapterLink
                    bookObject.sundayReviewLink = book.sundayReviewLink
                    bookObject.articleChapterLink = book.articleChapterLink
                    
                    let isbnObjects = book.isbns.map { isbn -> IsbnObject in
                        let isbnObject = IsbnObject()
                        isbnObject.isbn10 = isbn.isbn10
                        isbnObject.isbn13 = isbn.isbn13
                        return isbnObject
                    }
                    bookObject.isbns.append(objectsIn: isbnObjects)
                    
                    let buyLinkObjects = book.buyLinks.map { buyLink -> BuyLinkObject in
                        let links = BuyLinkObject()
                        links.name = buyLink.name.rawValue
                        links.url = buyLink.url
                        return links
                    }
                    bookObject.buyLinks.append(objectsIn: buyLinkObjects)
                    return bookObject
                }
            categoryBookObject.books.append(objectsIn: bookObjects)
            realm.add(categoryBookObject)
        }
    }
    
}
