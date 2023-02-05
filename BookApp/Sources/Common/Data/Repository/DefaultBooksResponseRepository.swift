//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Network
import Combine
import RealmSwift

public final class DefaultBooksRepository {
    private let booksRemoteDataSource: BooksRemoteDataSourceProtocol
    private let mapper: BooksMapperProtocol
    
    public init(booksRemoteDataSource: BooksRemoteDataSourceProtocol, mapper: BooksMapperProtocol) {
        self.booksRemoteDataSource = booksRemoteDataSource
        self.mapper = mapper
    }
}

extension DefaultBooksRepository: BooksRepository {
    public func fetchBooksByCategory(listName: String, date: String) -> AnyPublisher<BooksResponse.CategoryBook, DataTransferError> {
        let realm = try! Realm()
        let booksResponseObject = realm.objects(CategoryBookObject.self).filter("listNameEncoded = '\(listName)'").first
        
        if let object = booksResponseObject {
            let booksResponse = mapResults(object: object)
            return Just(booksResponse)
                .setFailureType(to: DataTransferError.self)
                .eraseToAnyPublisher()
        } else {
            return booksRemoteDataSource.fetchBooksByCategory(listName: listName, date: date)
                .map { [weak self] booksResponse in
                    let booksResponse = self?.mapper.mapCategory(booksResponse)
                    self?.cache(booksResponse: booksResponse!)
                    return booksResponse!.results
                }
                .eraseToAnyPublisher()
        }
    }
    
    private func mapResults(object: CategoryBookObject) -> BooksResponse.CategoryBook{
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
    
    private func mapBook(object: List<BookObject>) -> [BooksResponse.CategoryBook.Book]{
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
    private func mapIsbn(object: List<IsbnObject>) -> [BooksResponse.CategoryBook.Isbn]{
        object.map { isbnObject in
            return BooksResponse.CategoryBook.Isbn(isbn10: isbnObject.isbn10, isbn13: isbnObject.isbn13)
        }
    }
    func mapLinks(object: List<BuyLinkObject>) -> [BooksResponse.CategoryBook.BuyLink]{
        object.map { buyObject in
            return BooksResponse.CategoryBook.BuyLink(name: Name(rawValue: buyObject.name)!, url: buyObject.url)
        }
    }
    
    private func cache(booksResponse: BooksResponse) {
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
