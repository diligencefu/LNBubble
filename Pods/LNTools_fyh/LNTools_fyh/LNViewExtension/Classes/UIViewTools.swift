//
//  UIViewTools.swift
//  AFNetworking
//
//  Created by 付耀辉 on 2020/3/19.
//
import UIKit
@objc public extension UIView {
    
    var ln_x : CGFloat {
        get {
            frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    var ln_y : CGFloat {
        get {
            frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    var ln_width:CGFloat{
        get {
            bounds.width
        }
        set {
            self.bounds = CGRect.init(x: 0, y: 0, width: newValue, height: self.bounds.height)
        }

    }
    
    var ln_height:CGFloat{

        get {
            bounds.height
        }
        
        set {
            self.bounds = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: newValue)
        }

    }
    
    var ln_centerY:CGFloat {
        get {
            center.y
        }
        set {
            center.y = newValue
        }
    }
    
    var ln_centerX:CGFloat {
        get {
            center.x
        }
        set {
            center.x = newValue
        }
    }
    
    var ln_right:CGFloat {
        get {
            ln_x+ln_width
        }
        set {
            ln_x = newValue - ln_width
        }
    }
    
    var ln_bottom:CGFloat {
        get {
            ln_y+ln_height
        }
        set {
            ln_y = newValue - ln_height
        }
    }
    
    var ln_origin : CGPoint {
        get {
            self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    
    var ln_size : CGSize {
        get {
            self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }

    @objc func ln_viewContainingController()->UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    @IBInspectable var ln_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var ln_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var ln_borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

//调试模式输出
public func WWZLDebugPrint<T>(item message:T, file:String = #file, function:String = #function,line:Int = #line) {
    
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName):\(line) | \(message)")
    #endif
}

public extension UIScreen {
    
    static var width:CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var height:CGFloat {
        UIScreen.main.bounds.height
    }
    
}

