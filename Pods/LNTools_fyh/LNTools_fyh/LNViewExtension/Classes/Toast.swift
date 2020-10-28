//
//  Toast.swift
//  LNTools_fyh
//
//  Created by MAC on 2020/10/11.
//

import Toast
import UIKit

public extension UIView {

    //MARK: 设置一个提醒
    public enum WWZLToastPosition {
        case top
        case center
        case bottom
    }
    
    public func ln_showToast(str:String,position:WWZLToastPosition = WWZLToastPosition.center,isUserInterfaceEnableWhenShow:Bool = true) {
        
        var tPsition = String()
        switch position {
        case .top:
            tPsition = CSToastPositionTop
        case .center:
            tPsition = CSToastPositionCenter
        default:
            tPsition = CSToastPositionBottom
        }
        DispatchQueue.main.async {
            let kWindow = UIApplication.shared.keyWindow
            if !isUserInterfaceEnableWhenShow {
                kWindow?.isUserInteractionEnabled = false
            }
            let style = CSToastStyle.init(defaultStyle: ())
            kWindow?.makeToast(str, duration: 2.0, position: tPsition, style: style)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5, execute: {
                kWindow?.isUserInteractionEnabled = true
            })
        }
    }
}

public extension DispatchQueue {
    static func ln_runInMain(_ block: @escaping () -> Void) -> Void {
        if Thread.current == Thread.main {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
