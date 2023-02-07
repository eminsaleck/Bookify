//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 07.02.2023.
//

import Foundation
import UIKit

public extension UIStackView{
    
    func bordered() {
        self.layer.borderWidth = 0.05
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 20
    }
}

