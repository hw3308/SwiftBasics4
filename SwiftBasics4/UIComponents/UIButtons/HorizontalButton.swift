//
//  HorizontalButton.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/21.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation
import UIKit

open class HorizontalButton: UIButton {
    
    open var gap: CGFloat = 5
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        let marginLeft = (self.frame.width - imageView.frame.width - titleLabel.frame.width - self.gap)/2.0;
        
        var titleFrame = titleLabel.frame
        titleFrame.origin.x = marginLeft
        titleLabel.frame = titleFrame
        titleLabel.textAlignment = .right
        
        var imageFrame = imageView.frame;
        imageFrame.origin.x = marginLeft + titleLabel.frame.width + self.gap
        imageView.frame = imageFrame
    }
}

