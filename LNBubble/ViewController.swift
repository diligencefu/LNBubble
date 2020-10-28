//
//  ViewController.swift
//  LNBubble
//
//  Created by MAC on 2020/10/28.
//

import UIKit
import LNTools_fyh

class ViewController: UIViewController  {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            navigationItem.title = "自定义控件"
                    
            for view in self.view.subviews {
                if let button = view as? UIButton {
                    button.layer.cornerRadius = 3
                    button.backgroundColor = UIColor.init(red: 81, green: 64, blue: 251)
                    button.setTitleColor(.white, for: .normal)
                }
            }
            
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem.init(title: "气泡1", style: .plain, target: self, action: #selector(showBubble1(_:))),UIBarButtonItem.init(title: "气泡2", style: .plain, target: self, action: #selector(showBubble1(_:)))]
            
        }

        @objc func showBubble1(_ sender: UIBarButtonItem) {
                
            let bubble = BubbleViewController.init(lineHeight: 44, titles: ["价格升序","价格降序","热量排序","距离优先","成交量多优先"], sender: sender)
            bubble.didSelectAction { (title, index) in
                DispatchQueue.ln_runInMain {
                    self.view.ln_showToast(str: title)
                }
            }
            self.present(bubble, animated: false, completion: nil)
        }
        

        var isWithTitle = true
        @IBAction func sheetAction(_ sender: UIButton) {
            isWithTitle = !isWithTitle
            let tipVc = LNSheetViewController.init(titles: ["常亮","闪烁","关闭"], title: isWithTitle ? "提示":nil)
            tipVc.didSelectAction {(title, index) in
                self.view.ln_showToast(str: title)
            }
            self.present(tipVc, animated: false, completion: nil)
        }
        
        
        @IBAction func showBubble(_ sender: UIButton) {
            
            let bubble = BubbleViewController.init(lineHeight: 44, titles: ["价格升序","价格降序价格降序价格降序价格降序价格降序","热量排序","距离优先","成交量多优先"], sender: sender)
            bubble.didSelectAction { (title, index) in
                DispatchQueue.ln_runInMain {
                    sender.setTitle(title, for: .normal)
                }
            }
            self.present(bubble, animated: false, completion: nil)
        }
        
        
        func showBubble(titles: [String]) {
            let a = BubbleStle.init(show: 2, hidden: 2)
            a.aaaa(l: 1)
        }

                
    }




    struct BubbleStle {
        var show = 1
        var hidden = 2
        
        func aaaa(l: Int) {
            
        }
    }

