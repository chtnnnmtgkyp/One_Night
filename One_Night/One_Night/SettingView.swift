//
//  SettingView.swift
//  One_Night
//
//  Created by bui manh tri on 7/10/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit
import RealmSwift

class SettingView: UIView {

    var i:Int = 0
    @IBOutlet var btnEditNarration: UIButton!
    var view:UIView!
    
    @IBOutlet var btnEditGameTimer: UIButton!
    
    @IBOutlet var btnEditRoleTimer: UIButton!
    
    @IBOutlet var btnEditOther: UIButton!
    
    @IBOutlet var btnLayoutNarration: UIButton!
    
    @IBOutlet var btnLayoutGameTimer: UIButton!
    
    @IBOutlet var btnLayoutRoleTimer: UIButton!
    
    @IBOutlet var btnLayoutOther: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.btnEditNarration.layer.cornerRadius = self.btnEditNarration.frame.size.height/3
        self.btnEditNarration.layer.masksToBounds = true
        self.btnEditNarration.layer.borderWidth = 1.7

        let realm = try! Realm()
        let allPeople = realm.objects(NarrationButton)
        if allPeople.count == 0 {
            self.addValue()
        }else{
            self.updateValue()
            print("year")
        }
        self.queryPeople()

        
        self.btnEditGameTimer.layer.cornerRadius = self.btnEditGameTimer.frame.size.height/3
        self.btnEditGameTimer.layer.masksToBounds = true
        self.btnEditGameTimer.layer.borderWidth = 1.7

        self.btnLayoutGameTimer.layer.borderWidth = 1.7
        self.btnLayoutGameTimer.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.btnEditRoleTimer.layer.cornerRadius = self.btnEditRoleTimer.frame.size.height/3
        self.btnEditRoleTimer.layer.masksToBounds = true
        self.btnEditRoleTimer.layer.borderWidth = 1.7

        self.btnLayoutRoleTimer.layer.borderWidth = 1.7
        self.btnLayoutRoleTimer.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.btnEditOther.layer.cornerRadius = self.btnEditOther.frame.size.height/3
        self.btnEditOther.layer.masksToBounds = true
        self.btnEditOther.layer.borderWidth = 1.7

        self.btnLayoutOther.layer.borderWidth = 1.7
        self.btnLayoutOther.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(view)
    }
    
    func addValue(){
        let mike = NarrationButton()
        mike.countClick = 0
        mike.changeValue = 0
        let realm = try! Realm()
        try! realm.write{
            realm.add(mike, update: true)
            print("Added \(mike.countClick) to Realm")
            print("aaa")
        }
        self.btnLayoutNarration.layer.borderWidth = 1.7
        self.btnLayoutNarration.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func updateValue(){
        let realm = try! Realm()
        let allPeople = realm.objects(NarrationButton)
        try! realm.write{
            for person in allPeople{
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnLayoutNarration.layer.borderWidth = 1.7
                    self.btnLayoutNarration.layer.borderColor = UIColor.whiteColor().CGColor
                }else{
                    self.btnLayoutNarration.layer.borderWidth = 1.7
                    self.btnLayoutNarration.layer.borderColor = UIColor.blackColor().CGColor
                }
            }
        }
        
    }
    
    func queryPeople(){
        let realm = try! Realm()
        let allPeople = realm.objects(NarrationButton)
        for person in allPeople {
            print("\(person.countClick) years old")
        }
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "SettingView", bundle:bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func ClickNarration(sender: AnyObject) {
        let realm = try! Realm()
        let allPeople = realm.objects(NarrationButton)
        try! realm.write{
            for person in allPeople{
                person.countClick += 1
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnLayoutNarration.layer.borderWidth = 1.7
                    self.btnLayoutNarration.layer.borderColor = UIColor.whiteColor().CGColor
                }else{
                    self.btnLayoutNarration.layer.borderWidth = 1.7
                    self.btnLayoutNarration.layer.borderColor = UIColor.blackColor().CGColor
                }
            }
        }

    }
    

}
