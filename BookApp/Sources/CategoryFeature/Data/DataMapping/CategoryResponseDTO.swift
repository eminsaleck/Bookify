//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Common

public struct CategoryResponseDTO: Decodable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [CategoryListDTO]
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}
