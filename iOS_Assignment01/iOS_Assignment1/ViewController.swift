//
//  ViewController.swift
//  iOS_Assignment1
//
//  Created by 本田裕規 on 2017-05-24.
//  Copyright © 2017 本田裕規. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var titleConstraints: [NSLayoutConstraint] = [
        NSLayoutConstraint(item: self.titleLabel, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: self.titleLabel, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
        NSLayoutConstraint(item: self.titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
    ]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.backgroundColor = UIColor.blue
        label.text = "Scan Results"
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        // Labelを作成
//        let label: UILabel = UILabel(frame:CGRect(x:0,y:0,width:100,height:50))
//        label.text = "Label Dayo"
//        label.textColor = UIColor.black
//        label.shadowColor = UIColor.gray
//        label.textAlignment = NSTextAlignment.center
//        label.layer.position = CGPoint(x:label.bounds.width/2,y:label.bounds.height/2)
        
//        let widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 300)
//        let heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 200)
//        let constraints = NSLayoutConstraint.constraints(
//            withVisualFormat: "V:[superview]-(<=1)-[label]",
//            options: NSLayoutFormatOptions.alignAllCenterX,
//            metrics: nil,
//            views: ["superview":view, "label":label])
//
//        view.addConstraints(titleConstraints)
        self.view.addSubview(titleLabel)
        
        let newView2 = UIView()
        newView2.backgroundColor = UIColor.blue
        newView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView2)
        
        let newView = UIView()
        newView.backgroundColor = UIColor.red
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)

        
        
        /*
        let horizontalConstraint = NSLayoutConstraint(
            // first item attitude
            item: newView,
            attribute: NSLayoutAttribute.leading,
            // EQUALS
            relatedBy: NSLayoutRelation.equal,
            // second item attitude
            toItem: view,
            attribute: NSLayoutAttribute.centerX,
            // y = ax + b
            // first item attitude = multiplaier * (second item attitude) + constant
            multiplier: 1,
            constant: 0)
        */
        
        let horizontalConstraint = NSLayoutConstraint(
            // first item attitude
            item: newView2,
            attribute: NSLayoutAttribute.bottom,
            // EQUALS
            relatedBy: NSLayoutRelation.equal,
            // second item attitude
            toItem: newView,
            attribute: NSLayoutAttribute.bottom,
            // y = ax + b
            // first item attitude = multiplaier * (second item attitude) + constant
            multiplier: 1,
            constant: 20)
        
        
        let verticalConstraint = NSLayoutConstraint(
            item: newView2,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: newView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: 20)
        let widthConstraint = NSLayoutConstraint(
            item: newView,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 100)
        let heightConstraint = NSLayoutConstraint(
            item: newView,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 100)
        
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        let horizontalConstraint2 = NSLayoutConstraint(
            item: newView2,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: view,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 20)
        let verticalConstraint2 = NSLayoutConstraint(
            item: newView2,
            attribute: NSLayoutAttribute.centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: view,
            attribute: NSLayoutAttribute.centerY,
            multiplier: 1,
            constant: 0)
        let widthConstraint2 = NSLayoutConstraint(
            item: newView2,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 300)
        let heightConstraint2 = NSLayoutConstraint(
            item: newView2,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: NSLayoutAttribute.notAnAttribute,
            multiplier: 1,
            constant: 300)
        
        view.addConstraints([horizontalConstraint2, verticalConstraint2, widthConstraint2, heightConstraint2])
        
        
        
//        print(self.view.perform(Selector(("recursiveDescription"))))
        
//        let button: UIButton = UIButton(frame:CGRect(x:0,y:0,width:100,height:50))
//        button.backgroundColor = UIColor.red
//        button.addTarget(self, action: #selector(ViewController.ratingButtonTapped(_:)), for: .touchDown)
//        button.setTitle("Button1", for: .normal)
////        button.layer.position = CGPoint(x:label.bounds.width/2,y:label.bounds.height/2)
//        
//        self.view.addSubview(button)
        
    }
    
    // MARK: Button Action
    func ratingButtonTapped(_ button: UIButton) {
        print("Button pressed 👍")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

