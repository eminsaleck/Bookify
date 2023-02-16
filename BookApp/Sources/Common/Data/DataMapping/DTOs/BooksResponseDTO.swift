//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Foundation

public struct BooksResponseDTO: Codable {
    public   let status, copyright: String
    public  let numResults: Int
    public  let lastModified: String
    public  let results: CategoryBookDTO

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case lastModified = "last_modified"
        case results
    }
}

// MARK: - Results
public struct CategoryBookDTO: Codable {
    public let listName, listNameEncoded, bestsellersDate, publishedDate: String
    public let publishedDateDescription, nextPublishedDate, previousPublishedDate, displayName: String
    public let normalListEndsAt: Int
    public let updated: String
    public let books: [BookDTO]
    public let corrections: [String]

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case nextPublishedDate = "next_published_date"
        case previousPublishedDate = "previous_published_date"
        case displayName = "display_name"
        case normalListEndsAt = "normal_list_ends_at"
        case updated, books, corrections
    }
}

// MARK: - Book
public struct BookDTO: Codable {
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
    public let isbns: [IsbnDTO]
    public let buyLinks: [BuyLinkDTO]
    public let bookURI: String

    enum CodingKeys: String, CodingKey {
        case rank
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case asterisk, dagger
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case publisher, description, price, title, author, contributor
        case contributorNote = "contributor_note"
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case amazonProductURL = "amazon_product_url"
        case ageGroup = "age_group"
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
        case isbns
        case buyLinks = "buy_links"
        case bookURI = "book_uri"
    }
}

// MARK: - BuyLink

public struct IsbnDTO: Codable {
    public  let isbn10, isbn13: String
}

public struct BuyLinkDTO: Codable {
    public let name: Name
    public let url: String
}

public enum Name: String, Codable {
    case amazon = "Amazon"
    case appleBooks = "Apple Books"
    case barnesAndNoble = "Barnes and Noble"
    case booksAMillion = "Books-A-Million"
    case bookshop = "Bookshop"
    case indieBound = "IndieBound"
}
