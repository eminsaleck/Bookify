//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common

struct CategoryResponse {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [CategoryList]
}
