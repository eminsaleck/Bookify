//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Foundation
import UIKit

public final class GradientView: UIView {
  
    public override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  fileprivate func setupView() {
    autoresizingMask = [.flexibleWidth, .flexibleHeight]
    guard let theLayer = self.layer as? CAGradientLayer else {
      return;
    }
      
    theLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    theLayer.locations = [0.0, 0.7]
    theLayer.frame = self.bounds
  }
  
    public override class var layerClass: AnyClass {
    return CAGradientLayer.self
  }
}
