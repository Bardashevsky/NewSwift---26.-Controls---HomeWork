//
//  ViewController.swift
//  NewSwift - 26. Controls
//
//  Created by Oleksandr Bardashevskyi on 10/31/18.
//  Copyright © 2018 Oleksandr Bardashevskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Global variables
    var actionView = UIView()
    var timeAnimation = Double()
    var centerOfActionView = CGPoint()

    //MARK: - Enum for changedBackgroundPicture
    enum backgroundValueSegmentedControl : Int {
        case firstBackgroundValue = 0
        case secondBackgroundValue = 1
        case thirdBackgroundValue = 2
    }
    //MARK: - Outlets:
    @IBOutlet weak var changePlaygroundAction: UISegmentedControl!
    @IBOutlet weak var rotationOutlet: UISwitch!
    @IBOutlet weak var changeSizeOutlet: UISwitch!
    @IBOutlet weak var translationOutlet: UISwitch!
    
    @IBOutlet weak var changedValueOutlet: UISlider!
    @IBOutlet weak var displayChangeValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timeAnimation = 5
        
        let image = UIImage(named: "planet.jpg")
        self.actionView.frame = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height/4, width:  (image?.size.width)!, height: (image?.size.height)!)
        self.actionView.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/4)
        centerOfActionView = self.actionView.center
        self.actionView.backgroundColor = UIColor(patternImage: image!)
        self.actionView.layer.cornerRadius = self.actionView.frame.width/2
        self.actionView.autoresizingMask = UIView.AutoresizingMask.init(rawValue: UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleBottomMargin.rawValue)
        self.view.addSubview(self.actionView)
        refreshScreen()
    }
    
    //MARK: - Functions:
    
    func refreshScreen() {
        
        if self.changePlaygroundAction.selectedSegmentIndex == backgroundValueSegmentedControl.firstBackgroundValue.rawValue {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "first.jpg")!)
        } else if self.changePlaygroundAction.selectedSegmentIndex == backgroundValueSegmentedControl.secondBackgroundValue.rawValue {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue.jpg")!)
        } else if self.changePlaygroundAction.selectedSegmentIndex == backgroundValueSegmentedControl.thirdBackgroundValue.rawValue {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "third3.jpg")!)
        }
    }
    
    func rotation (view: UIView) {
        UIView.animate(withDuration: self.timeAnimation,
                       delay: 0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        let transform = view.transform.rotated(by: .pi)
                        view.transform = transform
        }) { (true) in
            weak var view1 = view
            if self.rotationOutlet.isOn {
                self.rotation(view: view1!)
            }
            
        }
    }
    func translation (view: UIView) {
        let w = Int(self.view.bounds.width) + 1
        let h = Int(self.view.bounds.height) + 1
        let random = Int(arc4random())
        let randomWidth = random % w
        let randomHeight = random % h
        
        UIView.animate(withDuration: self.timeAnimation,
                       delay: 0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        self.actionView.center = CGPoint(x: randomWidth, y: randomHeight)
        }) { (true) in
            weak var view1 = view
            
            if self.translationOutlet.isOn {
                self.translation(view: view1!)
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.actionView.center = self.centerOfActionView
                })
            }
        }
    }
    func changeSize (view: UIView) {
        UIView.animate(withDuration: self.timeAnimation,
                       delay: 0,
                       options: UIView.AnimationOptions.curveLinear,
                       animations: {
                        view.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                        
        }) { (true) in
            
            weak var view1 = view
            
            UIView.animate(withDuration: 0.5,
                           animations: {
                            view1!.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            })
            if self.changeSizeOutlet.isOn {
            self.changeSize(view: view1!)
            }
        }
    }
    
    func roundToPlaces(places:CGFloat) -> String{
        let aStr = String(format: "%5.2f", places)
        return aStr
    }
    
    // MARK: - Actions:
    @IBAction func rotationScaleTranslationActionSwitch(_ sender: UISwitch) {
        
        if self.rotationOutlet.isOn {
            rotation(view: self.actionView)
        }
        if self.changeSizeOutlet.isOn {
            changeSize(view: self.actionView)
        }
        if self.translationOutlet.isOn {
            translation(view: self.actionView)
        }
    }
    
    @IBAction func changedBackgroundAction(_ sender: UISegmentedControl) {
        refreshScreen()
    }
    @IBAction func senderValueForDisplay(_ sender: UISlider) {
        self.timeAnimation = 6.5 - Double(sender.value)
        self.displayChangeValue.text = "Speed: x" + roundToPlaces(places: CGFloat(sender.value))
        
    }
    
}

