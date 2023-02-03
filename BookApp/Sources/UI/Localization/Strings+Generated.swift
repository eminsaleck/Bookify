//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation

public enum Localized: String, CaseIterable {
    
    public static var currentLocale = Locale.current
    
    public func localized() -> String {
        return localizeKey(self.rawValue, Localized.currentLocale)
    }
    
    case mainScreen = "main_screen" 
}