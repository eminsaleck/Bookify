//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(_ string: String) {
        let url = URL(string: string)
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
