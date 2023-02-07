//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 07.02.2023.
//

import UIKit

public extension CALayer{
    
    func bordered() {
        self.borderWidth = 1.0
        self.borderColor = UIColor.gray.cgColor
        self.cornerRadius = 20
        self.shadowColor = UIColor.black.cgColor
        self.shadowOpacity = 0.5
        self.shadowRadius = 10.0
        self.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
}

