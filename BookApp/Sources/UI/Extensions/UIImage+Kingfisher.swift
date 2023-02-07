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
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 1024 * 1024 * 10
        cache.diskStorage.config.sizeLimit = 1024 * 1024 * 100
        
        let url = URL(string: string)
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
