//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Foundation

public final class DefaultBooksMapper: BooksMapperProtocol {

    
    public init() { }
    
    public func mapCategory(_ category: BooksResponseDTO) -> BooksResponse {
        return BooksResponse(results: mapCategoryBook(category.results),
                             lastModified: category.lastModified,
                             numResults: category.numResults,
                             status: category.status,
                             copyright: category.copyright)
    }
    
    private func mapCategoryBook(_ categoryBook: CategoryBookDTO) -> BooksResponse.CategoryBook {
        return BooksResponse.CategoryBook(listName: categoryBook.listName,
                                          listNameEncoded: categoryBook.listNameEncoded,
                                          bestsellersDate: categoryBook.bestsellersDate,
                                          publishedDate: categoryBook.publishedDate,
                                          publishedDateDescription: categoryBook.publishedDateDescription,
                                          nextPublishedDate: categoryBook.nextPublishedDate,
                                          previousPublishedDate: categoryBook.previousPublishedDate,
                                          displayName: categoryBook.displayName,
                                          normalListEndsAt: categoryBook.normalListEndsAt,
                                          updated: categoryBook.updated,
                                          books: mapBooks(categoryBook.books),
                                          corrections: categoryBook.corrections)
    }
    
    private func mapBooks(_ books: [BookDTO]) -> [BooksResponse.CategoryBook.Book] {
        return books.map { book in
            let isbns = mapLink(book.isbns)
            let buyLinks = mapLink(book.buyLinks)
            return BooksResponse.CategoryBook.Book(rank: book.rank,
                                                   rankLastWeek: book.rankLastWeek,
                                                   weeksOnList: book.weeksOnList,
                                                   asterisk: book.asterisk,
                                                   dagger: book.dagger,
                                                   primaryIsbn10: book.primaryIsbn10,
                                                   primaryIsbn13: book.primaryIsbn13,
                                                   publisher: book.publisher,
                                                   description: book.description,
                                                   price: book.price,
                                                   title: book.title,
                                                   author: book.author,
                                                   contributor: book.contributor,
                                                   contributorNote: book.contributor,
                                                   bookImage: book.bookImage,
                                                   bookImageWidth: book.bookImageWidth,
                                                   bookImageHeight: book.bookImageHeight,
                                                   amazonProductURL: book.amazonProductURL,
                                                   ageGroup: book.ageGroup,
                                                   bookReviewLink: book.bookReviewLink,
                                                   firstChapterLink: book.firstChapterLink,
                                                   sundayReviewLink: book.sundayReviewLink,
                                                   articleChapterLink: book.articleChapterLink,
                                                   isbns: isbns,
                                                   buyLinks: buyLinks,
                                                   bookURI: book.bookURI)
        }
    }
    
    private func mapLink(_ buyLink: [BuyLinkDTO]) -> [BooksResponse.CategoryBook.BuyLink] {
        buyLink.map {
            return BooksResponse.CategoryBook.BuyLink(name: $0.name, url: $0.url)
        }
    }
    
    private func mapLink(_ isbn: [IsbnDTO]) -> [BooksResponse.CategoryBook.Isbn] {
        isbn.map {
            return BooksResponse.CategoryBook.Isbn(isbn10: $0.isbn10, isbn13: $0.isbn13)
        }
    }
    
}
