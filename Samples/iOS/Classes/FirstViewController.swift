//
//  FirstViewController.swift
//  Example
//
//  Created by Ignacio Romero on 5/22/16.
//  Copyright © 2016 DZN Labs All rights reserved.
//

import UIKit
import Iconic

class FirstViewController: UITableViewController {

    let cellIconSize:CGFloat = 22.0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() -> Void {
        
        let tabItem = UITabBarItem(icon: .Book, size:20, title: "Catalog", tag: 0)
        
        self.title = tabItem.title;
        self.tabBarItem = tabItem;
        
        let buttonItem = UIBarButtonItem(icon: .Cog, size:24, target: self, action: NSSelectorFromString("didTapRightItem"))
        self.navigationItem.rightBarButtonItem = buttonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTitleView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func didTapRightItem() {
        // Do something
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Icon.TotalCount.rawValue
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") {
            
            if let icon = Icon(rawValue: indexPath.row) {
                cell.imageView?.image = Iconic.image(forIcon: icon, size: cellIconSize, color: tableView.tintColor)
                cell.imageView?.highlightedImage = Iconic.image(forIcon: icon, size: cellIconSize, color: .whiteColor())
                
                cell.textLabel?.text = NSStringFromIcon(icon)

                if let unicode = Iconic.unicodeString(forIcon: icon),
                    let unicodedData = unicode.dataUsingEncoding(NSNonLossyASCIIStringEncoding),
                    let unicodeString = String(data: unicodedData, encoding: NSUTF8StringEncoding) {
                    cell.detailTextLabel?.text = unicodeString
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.setSelected(false, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellIconSize + cellIconSize*1.2
    }
    
    override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.copy(_:)) {
            return true
        }
        return false
    }
    
    override func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        // Copy
        if let icon = Icon(rawValue: indexPath.row) {
            let pasteboard = UIPasteboard.generalPasteboard()
            let string = NSStringFromIcon(icon)
            
            pasteboard.string = string
            print("Copied '\(string)' to paste board!")
        }
    }
}

extension UIViewController {
    
    func updateTitleView() {
        
        guard let title = self.title else {
            return
        }
        
        let icon = Icon(rawValue: self.tabBarItem.tag)
        let color = self.view.tintColor
        let titleSize = CGFloat(20)
        let edgeInsets = UIEdgeInsetsMake(0, 0, 0, titleSize/2)
        
        
        let attributes = [NSForegroundColorAttributeName: color,
                          NSFontAttributeName: UIFont.systemFontOfSize(titleSize)]
        
        let labelString = NSMutableAttributedString(string: title, attributes: attributes)
        
        if let iconString = Iconic.attributedString(forIcon: icon!, size: titleSize, color: color, edgeInsets: edgeInsets) {
            labelString.insertAttributedString(iconString, atIndex: 0)
        }
        
        let label = UILabel()
        label.attributedText = labelString
        label.sizeToFit()
        
        self.navigationItem.titleView = label
    }
}