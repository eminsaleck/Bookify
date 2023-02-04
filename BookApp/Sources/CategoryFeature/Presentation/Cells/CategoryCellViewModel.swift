//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common

protocol CategoryCellViewModelProtocol {
    var listName: String { get }
    var displayName: String { get }
    var listNameEncoded: String { get }
    var oldestPublishedDate: String { get }
    var newestPublishedDate: String { get }
    var updated: Updated { get }
    var years: String? { get }
}


final class CategoryCellViewModel: CategoryCellViewModelProtocol, Hashable {
    var listName: String
    
    var displayName: String
    
    var listNameEncoded: String
    
    var oldestPublishedDate: String
    
    var newestPublishedDate: String
    
    var updated: Common.Updated
    
    var years: String? {
        let startDate = getYear(from: oldestPublishedDate)
        let endDate = getYear(from: newestPublishedDate)
        return startDate + " - " + endDate
    }
    
    private let category: CategoryList
    
    public init(category: CategoryList) {
        self.category = category
        listName = category.listName
        displayName = category.displayName
        listNameEncoded = category.listNameEncoded
        oldestPublishedDate = category.oldestPublishedDate
        newestPublishedDate = category.newestPublishedDate
        updated = category.updated
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(listNameEncoded)
    }
    
    static func == (lhs: CategoryCellViewModel, rhs: CategoryCellViewModel) -> Bool {
        return lhs.listNameEncoded == rhs.listNameEncoded
    }

}

extension CategoryCellViewModel{
    
    private func getYear(from dateString: String?) -> String {
        guard let dateString = dateString else {
            return "?"
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "America/New_York")
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "yyyy"
            let yearString = formatter.string(from: date)
            return yearString
        } else {
            return "?"
        }
    }
}
