//
//  MyCustomView.swift
//  iOS_Assignment1
//
//  Created by 本田裕規 on 2017-05-24.
//  Copyright © 2017 本田裕規. All rights reserved.
//

import Foundation
import UIKit

class MyCustomView: UIView {
    var label: UILabel = UILabel()
    var myNames = ["dipen","laxu","anis","aakash","santosh","raaa","ggdds","house"]
    
    override init(){
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        label.frame = CGRectMake(50, 10, 200, 100)
        label.backgroundColor=UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "test label"
        label.hidden=true
        self.addSubview(label)
        
        var btn: UIButton = UIButton()
        btn.frame=CGRectMake(50, 120, 200, 100)
        btn.backgroundColor=UIColor.redColor()
        btn.setTitle("button", forState: UIControlState.Normal)
        btn.addTarget(self, action: "changeLabel", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btn)
        
        var txtField : UITextField = UITextField()
        txtField.frame = CGRectMake(50, 250, 100,50)
        txtField.backgroundColor = UIColor.grayColor()
        self.addSubview(txtField)
    }
}
