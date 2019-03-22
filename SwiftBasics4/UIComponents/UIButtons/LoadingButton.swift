//
//  LoadingButton.swift
//  SwiftBasics4
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 hw. All rights reserved.
//

import UIKit

@IBDesignable
public class LoadingButton: UIButton {
    
    public var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
    
    public var normalText: String! = ""
    
    @IBInspectable dynamic var defaultBackgroundColor: UIColor = UIColor.white {
        didSet {
            setBackgroundImage(UIImage.buttonImageWithColor(color: defaultBackgroundColor), for: .normal)
        }
    }
    
    @IBInspectable dynamic var highlightBackgroundColor: UIColor = UIColor.white {
        didSet {
            setBackgroundImage(UIImage.buttonImageWithColor(color: highlightBackgroundColor), for: .highlighted)
        }
    }
    
    @IBInspectable dynamic var disabledBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.setBackgroundImage(UIImage.buttonImageWithColor(color: disabledBackgroundColor), for: .disabled)
        }
    }
    
    @IBInspectable public var loadingText: String! = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    public func commonInit() {
        normalText = title(for: .normal)
        indicatorView.color = titleColor(for: .normal)
        indicatorView.isHidden = true
    }
    
    public func setupIndicatorView() {
        self.indicatorView.removeFromSuperview()
        self.indicatorView.frame = self.calculateIndicatorViewFrame()
        self.addSubview(indicatorView)
    }
    
    public func calculateIndicatorViewFrame() -> CGRect {
        let padding: CGFloat = 4
        var y = padding
        var height = self.frame.height - (padding * 2)
        var width = height
        var x = (self.frame.width / 2) - (width / 2)
        
        if let label = self.titleLabel {
            height = label.frame.height - 4
            width = height
            x = label.frame.origin.x - (width + padding)
            y = label.frame.origin.y +  ((label.frame.height - height) / 2.0)
            return CGRect.init(x: x, y: y, width: width, height: height)
        }
        
        return CGRect.init(x: x, y: y, width: width, height: height)
    }
    
    public func startAnimatingIndicatorView() {
        
        indicatorView.isHidden = false
        indicatorView.startAnimating()
    }
    
    public func stopAnimatingIndicatorView() {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
    }
    
    override public func draw(_ rect: CGRect) {
        self.setupIndicatorView()
        super.draw(rect)
    }
    
    deinit {
        print("MKLoadingButton deinit")
    }
}

//
// MARK: Public methods and properties
//
extension UIImage {
    
    class func buttonImageWithColor(color: UIColor, size:CGSize) -> UIImage {
        
        let rect:CGRect = CGRect.init(x:0, y:0, width:size.width, height:size.height);
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect);
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return img
    }
    
    class func buttonImageWithColor(color: UIColor) -> UIImage {
        
        return UIImage.buttonImageWithColor(color: color, size: CGSize(width: 1, height: 1))
    }
}

extension LoadingButton {
    public func disable() {
        
        if(!loadingText.isEmpty){
            self.setTitle(self.loadingText, for: .normal)
        }
        self.isUserInteractionEnabled = false
    }
    
    public func enable() {
        self.setTitle(self.normalText, for: .normal)
        self.isUserInteractionEnabled = true
    }
    
    public func startAnimating() {
        self.disable()
        self.startAnimatingIndicatorView()
    }
    
    public func stopAnimating() {
        self.enable()
        self.stopAnimatingIndicatorView()
    }
}
