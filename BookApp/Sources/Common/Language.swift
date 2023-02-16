//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

public enum Language: String, CaseIterable {
    case eng
    case ukr
    public init?(languageStrings languages: [String]) {
        guard let preferedLanguage = languages.first,
              let language = Language.init(
                rawValue: String(preferedLanguage.prefix(2).lowercased())) else {
            return nil
        }
        self = language
    }
}
