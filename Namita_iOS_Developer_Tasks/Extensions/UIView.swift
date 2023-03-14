//
//  UIView.swift
//  PrimeWomenPlate
//
//  Created by Apple on 20/04/20.
//  Copyright © 2020 Ogrelogic. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    @IBInspectable
     var cornerRadius: CGFloat {
       get {
         return layer.cornerRadius
       }
       set {
         layer.cornerRadius = newValue
       }
     }
     
     @IBInspectable
     var borderWidth: CGFloat {
       get {
         return layer.borderWidth
       }
       set {
         layer.borderWidth = newValue
       }
     }
     
     @IBInspectable
     var borderColor: UIColor? {
       get {
         if let color = layer.borderColor {
           return UIColor(cgColor: color)
         }
         return nil
       }
       set {
         if let color = newValue {
           layer.borderColor = color.cgColor
         } else {
           layer.borderColor = nil
         }
       }
     }
     
     @IBInspectable
     var shadowRadius: CGFloat {
       get {
         return layer.shadowRadius
       }
       set {
         layer.shadowRadius = newValue
       }
     }
     
     @IBInspectable
     var shadowOpacity: Float {
       get {
         return layer.shadowOpacity
       }
       set {
         layer.shadowOpacity = newValue
       }
     }
     
     @IBInspectable
     var shadowOffset: CGSize {
       get {
         return layer.shadowOffset
       }
       set {
         layer.shadowOffset = newValue
       }
     }
     
     @IBInspectable
     var shadowColor: UIColor? {
       get {
         if let color = layer.shadowColor {
           return UIColor(cgColor: color)
         }
         return nil
       }
       set {
         if let color = newValue {
           layer.shadowColor = color.cgColor
         } else {
           layer.shadowColor = nil
         }
       }
     }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.layer.add(animation, forKey: nil)
    }
    
    func addShadow(radius: CGFloat = 8.0){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = radius
        // self.layer.shouldRasterize = true
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    func addShadowToBottom(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        //self.layer.cornerRadius = 8.0
    }
    func removeShadow(){
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        //self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8.0
    }
    
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    func addInsideShadow(to edges: [UIRectEdge], radius: CGFloat = 30.0, opacity: Float = 0.8, color: CGColor = UIColor.black.cgColor) {
        
        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity
            
            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
     let mask = CAShapeLayer()
     mask.path = path.cgPath
     layer.mask = mask
     }
    
    func addShadowWithBlurOnView(spread: CGFloat,
                                      blur: CGFloat,
                                      color: UIColor?,
                                      opacity: Float,
                                      OffsetX: CGFloat,
                                      OffsetY: CGFloat) {
       
       
       self.layer.shadowOffset = CGSize(width: OffsetX, height: OffsetY)
        self.layer.shadowOpacity = opacity
       //Shadow Color
       if let shadowColor = color {
           self.layer.shadowColor = shadowColor.cgColor
       } else {
           self.layer.shadowColor = nil
       }
       //Shadow Blur
        self.layer.shadowRadius = blur / 2.0
       //Shadow Spread
       if spread == 0 {
           self.layer.shadowPath = nil
       } else {
           let dx = -spread
           let rect = self.bounds.insetBy(dx: dx, dy: dx)
           self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
       }
        self.layer.masksToBounds = false
        self.clipsToBounds = false
   }
}

/*Gradient Color*/
extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor], cornerradius: CGFloat) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil, cornerRadius: cornerradius)
    }

    func removeGradient() {
        for layer in self.layer.sublayers ?? []{
            if layer.isKind(of:CAGradientLayer.self){
                layer.removeFromSuperlayer()
            }
        }
    }
    
    
    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, cornerRadius: CGFloat) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = cornerRadius
        return gradient
    }
}

class CustomDashedView: UIView {

    @IBInspectable var kCornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
        
       
                
                
    }
}

extension UIView {
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
       layer.masksToBounds = false
       layer.shadowColor = color.cgColor
       layer.shadowOpacity = opacity
       layer.shadowOffset = offSet
       layer.shadowRadius = radius

       layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       layer.shouldRasterize = true
       layer.rasterizationScale = scale ? UIScreen.main.scale : 1
     }
}

