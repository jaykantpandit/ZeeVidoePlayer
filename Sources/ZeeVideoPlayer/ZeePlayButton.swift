//
//  ZeePlayButton.swift
//
//
//  Created by BizBrolly on 13/03/24.
//

import UIKit

public class ZeePlayButton: UIButton {

//  public var cornerRadius: CGFloat = 10 {
//    didSet {
//      layer.cornerRadius = cornerRadius
//    }
//  }
//
//  public var borderWidth: CGFloat = 1 {
//    didSet {
//      layer.borderWidth = borderWidth
//    }
//  }
//
//  public var borderColor: UIColor = .black {
//    didSet {
//      layer.borderColor = borderColor.cgColor
//    }
//  }


  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupButton()
  }

  // MARK: - Setup

  private func setupButton() {
    layer.masksToBounds = true // Clip subviews to rounded corners
    self.setImage(UIImage(systemName: "play.fill"), for: .normal)
  }
    
}
