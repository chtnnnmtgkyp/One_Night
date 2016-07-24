//
//  NarrationView.swift
//  One_Night
//
//  Created by bui manh tri on 7/11/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit
import RealmSwift

class NarrationView: UIView {
    
    @IBOutlet var btnMale: UIButton!
    @IBOutlet var btnFemale: UIButton!
    @IBOutlet var btnGender: UIButton!
    @IBOutlet var btnUp: UIButton!
    @IBOutlet var btnDown: UIButton!
    @IBOutlet var lblVolume: UILabel!
    
    var view:UIView!
    
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
        let realm = try! Realm()
        let allPeople = realm.objects(Male)
        if allPeople.count == 0 {
            self.addValue()
        }else{
            self.updateValue()
            self.updateValue1()
            self.updateValue2()
            self.updateValue3()
            print("year")
        }
        self.queryPeople()
        addSubview(view)
    }
    
    func addValue(){
        let mike = Male()
        let mike1 = FemaleButton()
        let mike2 = GenderSpecificButton()
        let volume = VolumeLabel()
        mike.changeValue = 0
        mike.countClick = 0
        mike1.changeValue = 0
        mike1.countClick = 0
        mike2.changeValue = 0
        mike2.countClick = 0
        volume.changeValue = 0
        volume.Volume = 10
        let realm = try! Realm()
        try! realm.write{
            realm.add(mike, update: true)
            realm.add(mike1, update: true)
            realm.add(mike2, update: true)
            realm.add(volume, update: true)
            print("Added \(mike.changeValue) to Realm")
            print("aaa")
        }
        
        self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
        self.btnMale.layer.masksToBounds = true
        self.btnMale.layer.borderWidth = 1.7
        self.btnMale.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
        self.btnFemale.layer.masksToBounds = true
        self.btnFemale.layer.borderWidth = 1.7
        self.btnFemale.layer.borderColor = UIColor.blackColor().CGColor
        
        self.btnGender.layer.cornerRadius = self.btnGender.frame.size.height/3
        self.btnGender.layer.masksToBounds = true
        self.btnGender.layer.borderWidth = 1.7
        self.btnGender.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func updateValue(){
        let realm = try! Realm()
        let allPeople = realm.objects(Male)
        try! realm.write{
            for person in allPeople{
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
                    self.btnMale.layer.masksToBounds = true
                    self.btnMale.layer.borderWidth = 1.7
                    self.btnMale.layer.borderColor = UIColor.whiteColor().CGColor
                }else{
                    self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
                    self.btnMale.layer.masksToBounds = true
                    self.btnMale.layer.borderWidth = 1.7
                    self.btnMale.layer.borderColor = UIColor.blackColor().CGColor
                }
            }
        }
        
    }
    
    func updateValue1(){
        let realm = try! Realm()
        let allPeople = realm.objects(FemaleButton)
        try! realm.write{
            for person in allPeople{
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
                    self.btnFemale.layer.masksToBounds = true
                    self.btnFemale.layer.borderWidth = 1.7
                    self.btnFemale.layer.borderColor = UIColor.blackColor().CGColor
                }else{
                    self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
                    self.btnFemale.layer.masksToBounds = true
                    self.btnFemale.layer.borderWidth = 1.7
                    self.btnFemale.layer.borderColor = UIColor.whiteColor().CGColor
                }
            }
        }
        
    }
    
    func updateValue2(){
        let realm = try! Realm()
        let allPeople = realm.objects(GenderSpecificButton)
        try! realm.write{
            for person in allPeople{
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnGender.layer.cornerRadius = self.btnFemale.frame.size.height/3
                    self.btnGender.layer.masksToBounds = true
                    self.btnGender.layer.borderWidth = 1.7
                    self.btnGender.layer.borderColor = UIColor.blackColor().CGColor
                }else{
                    self.btnGender.layer.cornerRadius = self.btnGender.frame.size.height/3
                    self.btnGender.layer.masksToBounds = true
                    self.btnGender.layer.borderWidth = 1.7
                    self.btnGender.layer.borderColor = UIColor.whiteColor().CGColor
                }
            }
        }
        
    }
    
    func updateValue3(){
        let realm = try! Realm()
        let allPeople = realm.objects(VolumeLabel)
        try! realm.write{
            for person in allPeople{
                print("Added \(person.Volume) to Realm")
                self.lblVolume.text = String(person.Volume)
            }
        }
        
    }
    
    func queryPeople(){
        let realm = try! Realm()
        let allPeople = realm.objects(Male)
        for person in allPeople {
            print("\(person.changeValue) is \(person.countClick) years old")
        }
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "NarrationView", bundle:bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
    @IBAction func clickMale(sender: AnyObject) {
        let realm = try! Realm()
        let allPeople = realm.objects(Male)
        try! realm.write{
            for person in allPeople{
                person.countClick += 1
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
                    self.btnMale.layer.masksToBounds = true
                    self.btnMale.layer.borderWidth = 1.7
                    self.btnMale.layer.borderColor = UIColor.whiteColor().CGColor
                }else{
                    self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
                    self.btnMale.layer.masksToBounds = true
                    self.btnMale.layer.borderWidth = 1.7
                    self.btnMale.layer.borderColor = UIColor.blackColor().CGColor
                }
            }
        }
        
        self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
        self.btnFemale.layer.masksToBounds = true
        self.btnFemale.layer.borderWidth = 1.7
        self.btnFemale.layer.borderColor = UIColor.blackColor().CGColor
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(FemaleButton)
        try! realm.write{
            for person in allPeople1{
                person.countClick = 0
            }
        }
        
        
        self.btnGender.layer.cornerRadius = self.btnGender.frame.size.height/3
        self.btnGender.layer.masksToBounds = true
        self.btnGender.layer.borderWidth = 1.7
        self.btnGender.layer.borderColor = UIColor.blackColor().CGColor
        let realm2 = try! Realm()
        let allPeople2 = realm2.objects(GenderSpecificButton)
        try! realm.write{
            for person in allPeople2{
                person.countClick = 0
            }
        }
    }
    
    @IBAction func clickFemale(sender: AnyObject) {
        let realm = try! Realm()
        let allPeople = realm.objects(FemaleButton)
        try! realm.write{
            for person in allPeople{
                person.countClick += 1
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
                    self.btnFemale.layer.masksToBounds = true
                    self.btnFemale.layer.borderWidth = 1.7
                    self.btnFemale.layer.borderColor = UIColor.blackColor().CGColor
                }else{
                    self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
                    self.btnFemale.layer.masksToBounds = true
                    self.btnFemale.layer.borderWidth = 1.7
                    self.btnFemale.layer.borderColor = UIColor.whiteColor().CGColor
                }
            }
        }
        
        self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
        self.btnMale.layer.masksToBounds = true
        self.btnMale.layer.borderWidth = 1.7
        self.btnMale.layer.borderColor = UIColor.blackColor().CGColor
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(Male)
        try! realm.write{
            for person in allPeople1{
                person.countClick = 1
            }
        }
        
        self.btnGender.layer.cornerRadius = self.btnGender.frame.size.height/3
        self.btnGender.layer.masksToBounds = true
        self.btnGender.layer.borderWidth = 1.7
        self.btnGender.layer.borderColor = UIColor.blackColor().CGColor
        let realm2 = try! Realm()
        let allPeople2 = realm2.objects(GenderSpecificButton)
        try! realm.write{
            for person in allPeople2{
                person.countClick = 0
            }
        }
    }
    
    
    @IBAction func clickGenderSpecific(sender: AnyObject) {
        let realm = try! Realm()
        let allPeople = realm.objects(GenderSpecificButton)
        try! realm.write{
            for person in allPeople{
                person.countClick += 1
                print("Added \(person.countClick) to Realm")
                if(person.countClick % 2 == 0){
                    self.btnGender.layer.cornerRadius = self.btnGender.frame.size.height/3
                    self.btnGender.layer.masksToBounds = true
                    self.btnGender.layer.borderWidth = 1.7
                    self.btnGender.layer.borderColor = UIColor.blackColor().CGColor
                }else{
                    self.btnGender.layer.cornerRadius = self.btnGender.frame.size.height/3
                    self.btnGender.layer.masksToBounds = true
                    self.btnGender.layer.borderWidth = 1.7
                    self.btnGender.layer.borderColor = UIColor.whiteColor().CGColor
                }
            }
        }
        
        self.btnMale.layer.cornerRadius = self.btnMale.frame.size.height/3
        self.btnMale.layer.masksToBounds = true
        self.btnMale.layer.borderWidth = 1.7
        self.btnMale.layer.borderColor = UIColor.blackColor().CGColor
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(Male)
        try! realm.write{
            for person in allPeople1{
                person.countClick = 1
            }
        }
        
        self.btnFemale.layer.cornerRadius = self.btnFemale.frame.size.height/3
        self.btnFemale.layer.masksToBounds = true
        self.btnFemale.layer.borderWidth = 1.7
        self.btnFemale.layer.borderColor = UIColor.blackColor().CGColor
        let realm2 = try! Realm()
        let allPeople2 = realm2.objects(FemaleButton)
        try! realm.write{
            for person in allPeople2{
                person.countClick = 0
            }
        }
    }
   
    @IBAction func RaiseVolClick(sender: AnyObject) {
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(VolumeLabel)
        try! realm1.write{
            for person in allPeople1{
                person.Volume += 1
                if person.Volume > 10{
                    person.Volume = 10
                    return
                }
                self.lblVolume.text = String(person.Volume)
                print(person.Volume)
            }
        }
        
    }
    
    
    @IBAction func DownVolClick(sender: AnyObject) {
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(VolumeLabel)
        try! realm1.write{
            for person in allPeople1{
                person.Volume -= 1
                if person.Volume < 0{
                    person.Volume = 0
                    return
                }
                self.lblVolume.text = String(person.Volume)
                print(person.Volume)
            }
        }
    }
    
    
}
