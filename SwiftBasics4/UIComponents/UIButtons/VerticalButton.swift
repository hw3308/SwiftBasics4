//
//  VerticalButton.swift
//  SwiftBasics4
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation
import UIKit

open class VerticalButton: UIButton {
    
    open var gap: CGFloat = 5
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        let marginTop = (frame.size.height - imageView.frame.size.height - titleLabel.frame.size.height - gap) / 2
        
        var center = imageView.center
        center.x = frame.size.width / 2
        center.y = imageView.frame.size.height / 2 + marginTop
        imageView.center = center
        
        // Center text
        var newFrame = titleLabel.frame
        newFrame.origin.x = 0
        newFrame.origin.y = imageView.frame.size.height + gap + marginTop
        newFrame.size.width = frame.size.width
        
        titleLabel.frame = newFrame
        titleLabel.textAlignment = .center
    }
    
}
