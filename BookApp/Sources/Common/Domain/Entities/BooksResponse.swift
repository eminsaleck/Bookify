//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//


import Foundation

public struct BooksResponse {
    public   let status, copyright: String
    public  let numResults: Int
    public  let lastModified: String
    public  let results: CategoryBook
    
    public init(results: CategoryBook,
                lastModified: String,
                numResults: Int,
                status: String,
                copyright: String) {
        self.results = results
        self.lastModified = lastModified
        self.numResults = numResults
        self.status = status
        self.copyright = copyright
    }
    
    public struct CategoryBook {
        public let listName,
                   listNameEncoded,
                   bestsellersDate,
                   publishedDate: String
        public let publishedDateDescription,
                   nextPublishedDate,
                   previousPublishedDate,
                   displayName: String
        public let normalListEndsAt: Int
        public let updated: String
        public let books: [Book]
        public let corrections: [String]
        
        public init(listName: String,
                    listNameEncoded: String,
                    bestsellersDate: String,
                    publishedDate: String,
                    publishedDateDescription: String,
                    nextPublishedDate: String,
                    previousPublishedDate: String,
                    displayName: String,
                    normalListEndsAt: Int,
                    updated: String,
                    books: [Book],
                    corrections: [String]
        )
        {
            self.listName = listName
            self.listNameEncoded = listNameEncoded
            self.bestsellersDate = bestsellersDate
            self.publishedDate = publishedDate
            self.publishedDateDescription = publishedDateDescription
            self.nextPublishedDate = nextPublishedDate
            self.previousPublishedDate = previousPublishedDate
            self.displayName = displayName
            self.normalListEndsAt = normalListEndsAt
            self.updated = updated
            self.books = books
            self.corrections = corrections
        }
        
        public struct BuyLink: Hashable {
            public let name: Name
            public let url: String
            
            public init(name: Name, url: String){
                self.name = name
                self.url = url
            }
        }
        
        public struct Isbn {
            public let isbn10, isbn13: String
            
            public init(isbn10: String, isbn13: String){
                self.isbn10 = isbn10
                self.isbn13 = isbn13
            }
        }
        
        public struct Book: Hashable, Equatable {
            public let rank, rankLastWeek, weeksOnList, asterisk: Int
            public let dagger: Int
            public let primaryIsbn10, primaryIsbn13, publisher, description: String
            public let price, title, author, contributor: String
            public let contributorNote: String
            public let bookImage: String
            public let bookImageWidth, bookImageHeight: Int
            public let amazonProductURL: String
            public let ageGroup: String
            public let bookReviewLink: String
            public let firstChapterLink: String
            public let sundayReviewLink: String
            public let articleChapterLink: String
            public let isbns: [Isbn]
            public let buyLinks: [BuyLink]
            public let bookURI: String
            
            public static func == (lhs: Book, rhs: Book) -> Bool {
                return lhs.rank == rhs.rank && lhs.primaryIsbn10 == rhs.primaryIsbn10 && lhs.title == rhs.title
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(rank)
                hasher.combine(primaryIsbn10)
                hasher.combine(title)
            }
        }
    }
}





