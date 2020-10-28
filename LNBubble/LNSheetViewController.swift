//
//  LNSheetViewController.swift
//  WWZLSumSDK
//
//  Created by 付耀辉 on 2020/4/14.
//  Copyright © 2020 信泰集团. All rights reserved.
//

import UIKit
import LNTools_fyh
class LNSheetViewController: UIViewController {
    
    fileprivate let identifier = "UITableViewIdentifier";
    fileprivate var mainTableView : UITableView!
    fileprivate var bottomSpace:CGFloat = 20
    fileprivate var borderSpace:CGFloat = 16
    fileprivate var titles = [String]()
    fileprivate var footView:UIView!
    fileprivate var showTitle:String?
    
    public var bgColor:UIColor = .black {
        didSet{
            
        }
    }
    public var separatorColor:UIColor = .white
    public var textColor:UIColor = .white
    public var titleColor:UIColor = .gray
    public var rowHeight:CGFloat = 54
    public var cornerRadius:CGFloat = 8 {
        didSet {
            if cornerRadius > 30 {
                cornerRadius = 30
            }
            
            if cornerRadius < 0 {
                cornerRadius = 0
            }
        }
    }

    public typealias LNDidSelectBlock = (_ title:String, _ index:Int) -> Void
    fileprivate var didSelect:LNDidSelectBlock? = nil
    public func didSelectAction(callback:@escaping LNDidSelectBlock) {
        self.didSelect = callback
    }
    
    
    init(titles:[String], title:String? = nil) {
        
        self.titles = titles
        showTitle = title
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        configSubViews()
    }
    
    
    fileprivate func configSubViews() {
                
        mainTableView = UITableView.init(frame: CGRect.init(x: borderSpace, y: UIScreen.height, width: UIScreen.width-borderSpace*2, height: 0), style: .plain)
        mainTableView.estimatedRowHeight = 100
        mainTableView.register(LNSheetCell.self, forCellReuseIdentifier: identifier)
        mainTableView.separatorColor = .clear
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView.init()
        mainTableView.backgroundColor = bgColor.withAlphaComponent(0.95)
        mainTableView.isScrollEnabled = false
        mainTableView.ln_cornerRadius = cornerRadius
        self.view.addSubview(mainTableView)
        
        let rightView = UIView.init(frame: CGRect.init(x: mainTableView.ln_right-16, y: 0, width: 16, height: mainTableView.ln_height))
        rightView.backgroundColor = bgColor.withAlphaComponent(0.95)
        mainTableView.addSubview(rightView)
        
        footView = UIView.init(frame: CGRect.init(x: mainTableView.ln_x, y: mainTableView.ln_bottom, width: mainTableView.ln_width, height: rowHeight+20))
        footView.backgroundColor = .clear
        let cancel = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: footView.ln_width, height: rowHeight))
        cancel.backgroundColor = bgColor.withAlphaComponent(0.95)
        cancel.ln_cornerRadius = cornerRadius
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(.white, for: .normal)
        cancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cancel.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        footView.addSubview(cancel)
        cancel.ln_y = 10
        
        self.view.addSubview(footView)
        
        var viewHeight = rowHeight*CGFloat(titles.count) + (showTitle == nil ? 0:rowHeight/4*3)
        if viewHeight > UIScreen.height - bottomSpace*2 - UIApplication.shared.statusBarFrame.height - footView.ln_height  {
            viewHeight = UIScreen.height - bottomSpace*2 - UIApplication.shared.statusBarFrame.height - footView.ln_height
            mainTableView.isScrollEnabled = true
        }
        mainTableView.ln_height = viewHeight
        footView.ln_y = mainTableView.ln_bottom
    }
    
    
    @objc func cancelAction() {
        UIView.animate(withDuration: 0.15, animations: {
            self.mainTableView.ln_y = UIScreen.height
            self.footView.ln_y = self.mainTableView.ln_bottom
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }) { (flag) in
            self.dismiss(animated:false, completion: nil)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        cancelAction()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.mainTableView.ln_y = UIScreen.height - self.mainTableView.ln_height - self.footView.ln_height
            self.footView.ln_y = UIScreen.height - self.footView.ln_height
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //debugPrint(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < -90 {
            cancelAction()
        }
    }
}


extension LNSheetViewController:UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! LNSheetCell
        cell.accessoryType = .none
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.setTitle(titles[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if showTitle != nil, indexPath.row == 0 {
//            return
//        }
        didSelect?(titles[indexPath.row], indexPath.row-(showTitle == nil ? 0:1))
        cancelAction()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: mainTableView.ln_width, height: rowHeight/4*3))
        titleView.backgroundColor = bgColor.withAlphaComponent(0.95)
        titleView.setTitle(showTitle, for: .normal)
        titleView.setTitleColor(titleColor, for: .normal)
        titleView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        let lineView = UIView.init()
        lineView.frame = CGRect.init(x: 0, y: 0, width: tableView.ln_width, height: 0.5)
        lineView.backgroundColor = self.separatorColor
        titleView.addSubview(lineView)
        lineView.ln_bottom = titleView.ln_bottom
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return showTitle == nil ? 0 : rowHeight/4*3
    }
}


class LNSheetCell: UITableViewCell {
    
    fileprivate let titleButton = UIButton.init()
    fileprivate let lineView = UIView.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        titleButton.frame = CGRect.init(x: 0, y: 0, width: self.contentView.ln_width, height: self.contentView.ln_height)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        titleButton.titleLabel?.textAlignment = .center
        titleButton.isUserInteractionEnabled = false
        titleButton.setTitleColor((ln_viewContainingController() as? LNSheetViewController)?.textColor, for: .normal)
        self.contentView.addSubview(titleButton)
        
        lineView.frame = CGRect.init(x: 16, y: 0, width: self.contentView.ln_width-32, height: 0.5)
        lineView.backgroundColor = (ln_viewContainingController() as? LNSheetViewController)?.separatorColor
        self.contentView.addSubview(lineView)
    }
    
    public func setTitle(_ title:String, index:Int) {
        titleButton.setTitle(title, for: .normal)
        lineView.isHidden = index == 0
    }
    
}
