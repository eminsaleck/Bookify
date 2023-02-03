//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import UIKit

public class ErrorView: UIView {

  public let messageLabel = UILabel(frame: .zero)

  public override init(frame: CGRect) {
    super.init(frame: frame)
      configView()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    configView()
  }

  public convenience init(message: String?) {
    self.init(frame: .zero)
    messageLabel.text = message
  }

  private func configView() {
    backgroundColor = .systemBackground
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center

    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(messageLabel)

    messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
    messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 8).isActive = true
  }
}
