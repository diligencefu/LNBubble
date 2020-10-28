//
//  UIColorTools.swift
//  LNTools_fyh
//
//  Created by MAC on 2020/10/11.
//

public extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alph:CGFloat = 1) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alph)
    }

    convenience init(gary: CGFloat) {
        self.init(red:gary / 255.0, green: gary / 255.0, blue: gary / 255.0, alpha: 1)
    }

    convenience init(hex:String){
        //处理数值
        var cString = hex.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    @objc public var rgba:LNRGBA? {
        get {
            if let components = self.cgColor.components {
                let rgba = LNRGBA.init()
                rgba.red = components[0]
                rgba.green = components[components.count == 2 ? 0:1]
                rgba.blue = components[components.count == 2 ? 0:2]
                rgba.alpha = components[components.count == 2 ? 1:3]
                        
                return rgba
            }else{
                return nil
            }
        }
    }
        
    class LNRGBA: NSObject {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        
        public override var description: String {
            get{
                return "red:\(red),green:\(green),blue:\(blue),alpha:\(alpha)"
            }
        }
    }
}
