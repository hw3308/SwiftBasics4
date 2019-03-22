//
//  NoDataView.swift
//  SwiftBasics4
//
//  Created by houwei on 2019/3/22.
//  Copyright © 2019年 侯伟. All rights reserved.
//

import Foundation

class NoDataView: UIView {
    
    var titleLabel: UILabel!
    
    var imageView: UIImageView!
    
    var imageYOffset: CGFloat = 168{
        didSet{
            if let _ = imageViewTopConstraint{
                imageViewTopConstraint?.constant = imageYOffset
            }
        }
    }
    
    var contentSpace: CGFloat = 16
    
    var refreshBlock:(() -> ())?
    
    var title:String?{
        didSet{
            titleLabel.text = title
        }
    }
    
    var image:UIImage?{
        didSet{
            imageView.image = image
        }
    }
    
    var imageViewTopConstraint:NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        self.addSubview(imageView)
        let centerX = NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0);
        imageView.addConstraint(centerX)
        
        let top = NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: imageYOffset);
        imageView.addConstraint(top)
        imageViewTopConstraint = top
        
        titleLabel = UILabel()
        titleLabel.textColor = lightGreyColor
        titleLabel.font = font(13)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        let x = NSLayoutConstraint.init(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0);
        titleLabel.addConstraint(x)
        
        let t = NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: contentSpace);
        titleLabel.addConstraint(t)
        
        let btn = UIButton(type: .custom)
        btn.frame = self.bounds
        btn.addTarget(self, action: Selector.init(("clickRetry")), for: .touchUpInside)
        self.addSubview(btn)
        self.bringSubviewToFront(btn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func clickRetry(_ sender: UIButton) {
        if let block = refreshBlock{
            block()
        }
    }
}
