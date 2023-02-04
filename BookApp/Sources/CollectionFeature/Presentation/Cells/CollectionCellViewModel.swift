//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//
import Foundation
import Common

public struct CollectionCellViewModel: Hashable {
    private var id = UUID().uuidString
    let title: String
    let description: String
    let author: String
    let publisher: String
    let image: String
    let rank: Int
    let links: [BooksResponse.CategoryBook.BuyLink]
    
    public init(book: BooksResponse.CategoryBook.Book) {
        title = book.title
        description = book.description
        author = book.author
        publisher = book.publisher
        image = book.bookImage
        rank = book.rank
        links = book.buyLinks
    }
    
    public static func == (lhs: CollectionCellViewModel, rhs: CollectionCellViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
