//
//  StringIconSnapshotTests.swift
//  Iconic
//
//  Created by Ignacio Romero on 9/10/16.
//  Copyright © 2016 DZN. All rights reserved.
//

import FBSnapshotTestCase

class StringIconSnapshotTests: BaseSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        
//        self.recordMode = false
    }
    
    func testSimpleString() {
        
        let string = FontAwesomeIcon.CameraRetro.attributedString(ofSize: 50, color: nil)
        let textView = UITextView()
        
        textView.attributedText = string
        textView.sizeToFit()
        
        self.verifyView(textView, withIdentifier: "")
    }
    
    func testFullIconMap() {
        
        var rect = CGRect(x: 0, y: 0, width: 500, height: 0)
        let attributedString = NSAttributedString.iconMapWithSize(20, spacing: 5, andColor: nil)
        
        let textView = UITextView(frame: rect)
        textView.attributedText = attributedString
        
        rect.size.height = textView.contentSize.height
        textView.frame = rect
        
        self.verifyView(textView, withIdentifier: "")
    }
    
    func testComposeString() {
        
        let icon = FontAwesomeIcon.Dribble
        
        let edgeInsets = ["left": UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15),
                          "bottom": UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0),
                          "right": UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0),
                          "top": UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)]
        
        for (kind, edgeInset) in edgeInsets {
            
            let attributedText = NSMutableAttributedString()
            let iconString = icon.attributedString(ofSize: 25, color: nil, edgeInsets: edgeInset)
            
            let titleAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(25),
                                   NSForegroundColorAttributeName: UIColor.blackColor()] as [String : AnyObject]
            
            let titleAttrString = NSAttributedString(string: icon.name, attributes: titleAttributes)
            
            attributedText.appendAttributedString(iconString)
            attributedText.appendAttributedString(titleAttrString)
            
            let textView = UITextView()
            
            textView.attributedText = attributedText
            textView.sizeToFit()
            
            self.verifyView(textView, withIdentifier: kind)
        }
    }
}
