//
//  ViewController.swift
//  One_Night
//
//  Created by bui manh tri on 7/7/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    @IBOutlet var vContain: UIView!
    
    var ArrayData = Array<Int>()
    var sln:Int = 0
    
    @IBOutlet var vSetting: UIView!
    @IBOutlet var vContact: UIView!
    @IBOutlet var clvCharacter: UICollectionView!
    @IBOutlet var btnSetting: UIButton!
    
    @IBOutlet var btnPlay: UIButton!
    
    @IBOutlet var btnGameTimer: UIButton!
    
    private let minItemSpacing: CGFloat = 8
    private let itemWidth: CGFloat      = 50
    private let headerHeight: CGFloat   = 0
    
    var backgroundMusicPlayer = AVAudioPlayer()
    var musicPlayer = AVAudioPlayer()
    
    var timer = NSTimer()
    var timer2 = NSTimer()
    var timer3 = NSTimer()
    
    var checkClick:Int = 0
    var countdown:Int = 0
    var counter:Int = 0
    var counterNext:Int = 0
    var counterDoppelganger:Float = 0.0
    var counterWereWolf:Float = 0.0
    var counterMinion:Float = 0.0
    var counterMason:Float = 0.0
    var counterSeer:Float = 0.0
    var counterRobber:Float = 0.0
    var counterTroublemaker:Float = 0.0
    var counterDrunk:Float = 0.0
    var counterInsomniac:Float = 0.0
    
    var counterWakeUp:Float = 0.0
    var counterVoteView:Float = 0.0
    
    var i:Int = 0
    var j:Float = 1
    
    var doppelgangerSubView:DoppelgangerView!
    var werewolfSubView:WerewolfView!
    var minionSubView:MinionView!
    var masonSubView:MasonView!
    var seerSubView:SeerView!
    var robberSubView:RobberView!
    var troublemakerSubView:TroublemakerView!
    var drunkSubView:DrunkView!
    var insomniacSubView:InsomniacView!
    
    var countDownSubView:CountDownView!
    var wakeupSubView:WakeUpView!
    var vote:VoteView!
    var tableData:[String] = ["doppelganger.png","werewolf.png","werewolf.png","Minion.png","mason.png","mason.png","seer.png","robber.png","troublemaker.png","drunk.png","insomniac.png","villager.png","villager.png","villager.png","hunter.png","tanner.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let realm1 = try! Realm()
        let gametimer = realm1.objects(GameTimerClick)
        for person in gametimer{
            if person.countClick % 2 == 0{
                self.btnGameTimer.layer.cornerRadius = 5
                self.btnGameTimer.layer.masksToBounds = true
                self.btnGameTimer.layer.borderWidth = 1.7
                self.btnGameTimer.layer.borderColor = UIColor.whiteColor().CGColor
                self.btnGameTimer.backgroundColor = UIColor.darkTextColor()
                self.btnGameTimer.setTitleColor(UIColor.whiteColor(), forState:.Normal)
                self.btnGameTimer.alpha = 0.9
            }
            else{
                self.btnGameTimer.layer.cornerRadius = 5
                self.btnGameTimer.layer.masksToBounds = true
                self.btnGameTimer.backgroundColor = UIColor.whiteColor()
                self.btnGameTimer.alpha = 0.2
                self.btnGameTimer.setTitleColor(UIColor.blackColor(), forState:.Normal)
            }
        }
        
        let allPeople1 = realm1.objects(VolumeBackGround)
        if allPeople1.count == 0 {
            self.addValue3()
        }else{
            self.updateValue3()
        }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        self.btnPlay.layer.cornerRadius = self.btnPlay.frame.size.height/2
        self.btnPlay.layer.masksToBounds = true
        self.btnPlay.layer.borderWidth = 1.7
        self.btnPlay.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.btnSetting.layer.cornerRadius = self.btnPlay.frame.size.height/2
        self.btnSetting.layer.masksToBounds = true
        self.btnSetting.layer.borderWidth = 1.7
        self.btnSetting.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.btnGameTimer.layer.cornerRadius = 5
        self.btnGameTimer.layer.masksToBounds = true
        self.btnGameTimer.layer.borderWidth = 1.7
        self.btnGameTimer.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.setSpacing()
        
        self.setSettingButton()
        let viewwithTag1 = self.view.viewWithTag(100)
        let viewwithTag2 = self.view.viewWithTag(101)
        if (viewwithTag1 != nil && viewwithTag2 != nil){
            viewwithTag1!.hidden = true
            viewwithTag2!.hidden = true
        }
        
        self.setHelpButton()
        let viewwithTag3 = self.view.viewWithTag(102)
        let viewwithTag4 = self.view.viewWithTag(103)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = true
            viewwithTag4!.hidden = true
        }
        
        self.setNarrationButton()
        let viewwithTag5 = self.view.viewWithTag(104)
        let viewwithTag6 = self.view.viewWithTag(105)
        if (viewwithTag5 != nil && viewwithTag6 != nil){
            viewwithTag5!.hidden = true
            viewwithTag6!.hidden = true
        }
        
        self.setStoryTelling()
        let viewwithTag7 = self.view.viewWithTag(106)
        let viewwithTag8 = self.view.viewWithTag(107)
        if (viewwithTag7 != nil && viewwithTag8 != nil){
            viewwithTag7!.hidden = true
            viewwithTag8!.hidden = true
        }
        
        self.setDoppelganger()
        let viewwithTag9 = self.view.viewWithTag(108)
        if (viewwithTag9 != nil){
            viewwithTag9!.hidden = true
        }
        
        self.setWereWolf()
        let viewwithTag10 = self.view.viewWithTag(109)
        if (viewwithTag10 != nil){
            viewwithTag10!.hidden = true
        }
        
        self.setMinion()
        let viewwithTag11 = self.view.viewWithTag(110)
        if (viewwithTag11 != nil){
            viewwithTag11!.hidden = true
        }
        
        self.setMason()
        let viewwithTag12 = self.view.viewWithTag(111)
        if (viewwithTag12 != nil){
            viewwithTag12!.hidden = true
        }
        
        self.setSeer()
        let viewwithTag13 = self.view.viewWithTag(112)
        if (viewwithTag13 != nil){
            viewwithTag13!.hidden = true
        }
        
        self.setRobber()
        let viewwithTag14 = self.view.viewWithTag(113)
        if (viewwithTag14 != nil){
            viewwithTag14!.hidden = true
        }
        
        self.setTroublemaker()
        let viewwithTag15 = self.view.viewWithTag(114)
        if (viewwithTag15 != nil){
            viewwithTag15!.hidden = true
        }
        
        self.setDrunk()
        let viewwithTag16 = self.view.viewWithTag(115)
        if (viewwithTag16 != nil){
            viewwithTag16!.hidden = true
        }
        
        self.setInsomniac()
        let viewwithTag17 = self.view.viewWithTag(116)
        if (viewwithTag17 != nil){
            viewwithTag17!.hidden = true
        }
        
        self.setWakeUp()
        let viewwithTag18 = self.view.viewWithTag(117)
        if (viewwithTag18 != nil){
            viewwithTag18!.hidden = true
        }
        
        self.setCountDown()
        let viewwithTag19 = self.view.viewWithTag(118)
        if (viewwithTag19 != nil){
            viewwithTag19!.hidden = true
        }
        
        self.setVoteView()
        let viewwithTag20 = self.view.viewWithTag(119)
        if (viewwithTag20 != nil){
            viewwithTag20!.hidden = true
        }
        
        
        let allPeople = realm1.objects(Doppelganger)
        if allPeople.count == 0 {
            self.addValue()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CharacterCell
        cell.imgCharactor.image = UIImage(named: tableData[indexPath.row])
        //if let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell.alpha = 0.5
        if indexPath.row == 0 {
            let realm = try! Realm()
            let doppelganger = realm.objects(Doppelganger)
            for person in doppelganger{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(0, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 1 {
            let realm = try! Realm()
            let werewolf = realm.objects(Werewolf)
            for person in werewolf{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(1, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 2 {
            let realm = try! Realm()
            let werewolf2 = realm.objects(Werewolf)
            for person in werewolf2{
                if(person.countClick2 % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(2, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 3 {
            let realm = try! Realm()
            let minion = realm.objects(Minion)
            for person in minion{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(3, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 4 {
            let realm = try! Realm()
            let mason = realm.objects(Mason)
            for person in mason{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(4, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 5 {
            let realm = try! Realm()
            let mason2 = realm.objects(Mason)
            for person in mason2{
                if(person.countClick2 % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(5, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 6 {
            let realm = try! Realm()
            let seer = realm.objects(Seer)
            for person in seer{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(6, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 7 {
            let realm = try! Realm()
            let robber = realm.objects(Robber)
            for person in robber{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(7, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 8 {
            let realm = try! Realm()
            let troublemaker = realm.objects(Troublemaker)
            for person in troublemaker{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(8, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 9 {
            let realm = try! Realm()
            let drunk = realm.objects(Drunk)
            for person in drunk{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(9, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 10 {
            let realm = try! Realm()
            let insomiac = realm.objects(Insomniac)
            for person in insomiac{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(10, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 11 {
            let realm = try! Realm()
            let villager = realm.objects(Villager)
            for person in villager{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(11, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 12 {
            let realm = try! Realm()
            let villager1 = realm.objects(Villager)
            for person in villager1{
                if(person.countClick2 % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(12, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 13 {
            let realm = try! Realm()
            let villager2 = realm.objects(Villager)
            for person in villager2{
                if(person.countClick3 % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(13, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 14 {
            let realm = try! Realm()
            let hunter = realm.objects(Hunter)
            for person in hunter{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(14, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        if indexPath.row == 15 {
            let realm = try! Realm()
            let tanner = realm.objects(Tanner)
            for person in tanner{
                if(person.countClick % 2 == 0){
                    cell.alpha = 0.2
                }else{
                    ArrayData.insert(15, atIndex: 0)
                    cell.layer.borderWidth = 0.5
                    cell.layer.borderColor = UIColor.whiteColor().CGColor
                    cell.alpha = 1
                }
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("cell \(indexPath.row) selected")
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            if indexPath.row == 0 {
                let realm = try! Realm()
                let doppelganger = realm.objects(Doppelganger)
                
                try! realm.write{
                    for person in doppelganger{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(0)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(0, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 1 {
                let realm = try! Realm()
                let werewolf = realm.objects(Werewolf)
                try! realm.write{
                    for person in werewolf{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(1)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(1, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 2 {
                let realm = try! Realm()
                let werewolf2 = realm.objects(Werewolf)
                try! realm.write{
                    for person in werewolf2{
                        person.countClick2 += 1
                        if(person.countClick2 % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(2)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(2, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 3 {
                let realm = try! Realm()
                let minion = realm.objects(Minion)
                try! realm.write{
                    for person in minion{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(3)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(3, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            
            if indexPath.row == 4 {
                let realm = try! Realm()
                let mason = realm.objects(Mason)
                try! realm.write{
                    for person in mason{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(4)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(4, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 5 {
                let realm = try! Realm()
                let mason2 = realm.objects(Mason)
                try! realm.write{
                    for person in mason2{
                        person.countClick2 += 1
                        if(person.countClick2 % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(5)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(5, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 6 {
                let realm = try! Realm()
                let seer = realm.objects(Seer)
                let checkClick = realm.objects(CheckClickSpecialCard)
                try! realm.write{
                    for person in seer{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            for checkclick in checkClick{
                                checkclick.countClick -= 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.removeAtIndex(ArrayData.indexOf(6)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            for checkclick in checkClick{
                                checkclick.countClick += 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.insert(6, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 7 {
                let realm = try! Realm()
                let robber = realm.objects(Robber)
                let checkClick = realm.objects(CheckClickSpecialCard)
                try! realm.write{
                    for person in robber{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            for checkclick in checkClick{
                                checkclick.countClick -= 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.removeAtIndex(ArrayData.indexOf(7)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            for checkclick in checkClick{
                                checkclick.countClick += 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.insert(7, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 8 {
                let realm = try! Realm()
                let troublemaker = realm.objects(Troublemaker)
                let checkClick = realm.objects(CheckClickSpecialCard)
                try! realm.write{
                    for person in troublemaker{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            for checkclick in checkClick{
                                checkclick.countClick -= 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.removeAtIndex(ArrayData.indexOf(8)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            for checkclick in checkClick{
                                checkclick.countClick += 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.insert(8, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 9 {
                let realm = try! Realm()
                let drunk = realm.objects(Drunk)
                let checkClick = realm.objects(CheckClickSpecialCard)
                try! realm.write{
                    for person in drunk{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            for checkclick in checkClick{
                                checkclick.countClick -= 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.removeAtIndex(ArrayData.indexOf(9)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            for checkclick in checkClick{
                                checkclick.countClick += 1
                                print("countClick: \(checkclick.countClick)")
                            }
                            ArrayData.insert(9, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 10 {
                let realm = try! Realm()
                let insomiac = realm.objects(Insomniac)
                try! realm.write{
                    for person in insomiac{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(10)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(10, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 11 {
                let realm = try! Realm()
                let villager = realm.objects(Villager)
                try! realm.write{
                    for person in villager{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(11)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(11, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 12 {
                let realm = try! Realm()
                let villager2 = realm.objects(Villager)
                try! realm.write{
                    for person in villager2{
                        person.countClick2 += 1
                        if(person.countClick2 % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(12)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(12, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 13 {
                let realm = try! Realm()
                let villager3 = realm.objects(Villager)
                try! realm.write{
                    for person in villager3{
                        person.countClick3 += 1
                        if(person.countClick3 % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(13)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(13, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 14 {
                let realm = try! Realm()
                let hunter = realm.objects(Hunter)
                try! realm.write{
                    for person in hunter{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(14)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(14, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
            if indexPath.row == 15 {
                let realm = try! Realm()
                let tanner = realm.objects(Tanner)
                try! realm.write{
                    for person in tanner{
                        person.countClick += 1
                        if(person.countClick % 2 == 0){
                            ArrayData.removeAtIndex(ArrayData.indexOf(15)!)
                            cell.layer.borderWidth = 0
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 0.2
                        }else{
                            ArrayData.insert(15, atIndex: 0)
                            cell.layer.borderWidth = 0.5
                            cell.layer.borderColor = UIColor.whiteColor().CGColor
                            cell.alpha = 1
                        }
                    }
                }
            }
            
        }
        
    }
    
    func addValue(){
        let checkClick = CheckClickSpecialCard()
        let clickGametimer = GameTimerClick()
        let doppelganger = Doppelganger()
        let werewolf = Werewolf()
        let minion = Minion()
        let mason = Mason()
        let seer = Seer()
        let robber = Robber()
        let troublemaker = Troublemaker()
        let drunk = Drunk()
        let insomiac = Insomniac()
        let villager = Villager()
        let hunter = Hunter()
        let tanner = Tanner()
        
        checkClick.changeValue = 0
        checkClick.countClick = 0
        clickGametimer.changeValue = 0
        clickGametimer.countClick = 0
        doppelganger.changeValue = 0
        doppelganger.countClick = 0
        werewolf.changeValue = 0
        werewolf.countClick = 0
        werewolf.countClick2 = 0
        minion.changeValue = 0
        minion.countClick = 0
        mason.changeValue = 0
        mason.countClick = 0
        mason.countClick2 = 0
        seer.changeValue = 0
        seer.countClick = 0
        robber.changeValue = 0
        robber.countClick = 0
        troublemaker.changeValue = 0
        troublemaker.countClick = 0
        drunk.changeValue = 0
        drunk.countClick = 0
        insomiac.changeValue = 0
        insomiac.countClick = 0
        villager.changeValue = 0
        villager.countClick = 0
        villager.countClick2 = 0
        villager.countClick3 = 0
        hunter.changeValue = 0
        hunter.countClick = 0
        tanner.changeValue = 0
        tanner.countClick = 0
        
        let realm = try! Realm()
        try! realm.write{
            realm.add(checkClick, update: true)
            realm.add(clickGametimer, update: true)
            realm.add(doppelganger, update: true)
            realm.add(werewolf, update: true)
            realm.add(minion, update: true)
            realm.add(mason, update: true)
            realm.add(seer, update: true)
            realm.add(robber, update: true)
            realm.add(troublemaker, update: true)
            realm.add(drunk, update: true)
            realm.add(insomiac, update: true)
            realm.add(villager, update: true)
            realm.add(hunter, update: true)
            realm.add(tanner, update: true)
            print("Added")
        }
    }
    
    //set size of collectionViewCell
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.bounds.size.width/5, collectionView.bounds.size.height/5)
    }
    
    //set spacing of collectionView cell
    func setSpacing() -> Void {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = minItemSpacing
        layout.minimumLineSpacing = minItemSpacing
        layout.headerReferenceSize = CGSize(width: 0, height: headerHeight)
        
        // Find n, where n is the number of item that can fit into the collection view
        var n: CGFloat = 1
        let containerWidth = clvCharacter.bounds.width
        while true {
            let nextN = n + 1
            let totalWidth = (nextN*itemWidth) + (nextN-1)*minItemSpacing
            if totalWidth > containerWidth {
                break
            } else {
                n = nextN
            }
        }
        
        let inset = max(minItemSpacing, floor( (containerWidth - (n*itemWidth) - (n-1)*minItemSpacing) / 2 ) )
        layout.sectionInset = UIEdgeInsets(top: minItemSpacing, left: inset, bottom: minItemSpacing, right: inset)
        
        clvCharacter.collectionViewLayout = layout
    }
    
    
    
    
    //click to GameTimer button
    @IBAction func ClickGameTimer(sender: AnyObject) {
        
        let realm1 = try! Realm()
        let gametimer = realm1.objects(GameTimerClick)
        try! realm1.write{
            for person in gametimer{
                person.countClick += 1
                if person.countClick % 2 == 0{
                    self.btnGameTimer.layer.cornerRadius = 5
                    self.btnGameTimer.layer.masksToBounds = true
                    self.btnGameTimer.layer.borderWidth = 1.7
                    self.btnGameTimer.layer.borderColor = UIColor.whiteColor().CGColor
                    self.btnGameTimer.backgroundColor = UIColor.darkTextColor()
                    self.btnGameTimer.setTitleColor(UIColor.whiteColor(), forState:.Normal)
                    self.btnGameTimer.alpha = 0.9
                }
                else{
                    self.btnGameTimer.layer.cornerRadius = 5
                    self.btnGameTimer.layer.masksToBounds = true
                    self.btnGameTimer.backgroundColor = UIColor.whiteColor()
                    self.btnGameTimer.alpha = 0.2
                    self.btnGameTimer.setTitleColor(UIColor.blackColor(), forState:.Normal)
                }
            }
        }
        
    }
    
    
    //setMusic
    func playBackgroundMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            let realm1 = try! Realm()
            let allPeople = realm1.objects(VolumeBackGround)
            try! realm1.write{
                for person in allPeople{
                    backgroundMusicPlayer.volume = Float(person.Volume)
                }
            }
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func playMusic(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            musicPlayer.numberOfLoops = 0
            let realm1 = try! Realm()
            let allPeople = realm1.objects(VolumeBackGround)
            try! realm1.write{
                for person in allPeople{
                    musicPlayer.volume = Float(person.Volume)
                }
            }
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func addValue3(){
        let mike = VolumeBackGround()
        mike.changeValue = 0
        mike.Volume = 1.0
        let realm = try! Realm()
        try! realm.write{
            realm.add(mike, update: true)
        }
    }
    
    func updateValue3(){
        let realm = try! Realm()
        let allPeople = realm.objects(VolumeBackGround)
        try! realm.write{
            for person in allPeople{
                print("Volume: \(person.Volume)")
            }
        }
        
    }
    
    //click to play button
    @IBAction func ClickToPlay(sender: AnyObject) {
        
        for array in ArrayData{
            print(array)
        }
        print(ArrayData.maxElement())
        print(".....")
        
        let realm = try! Realm()
        //let allPeople1 = realm.objects(FemaleButton)
        let gametimer = realm.objects(GameTimerClick)
        playBackgroundMusic("background_tense.mp3")
        
//        for person in allPeople1{
//            if person.countClick%2 == 1{
//                playBackgroundMusic("Remains.mp3")
//            }else{
//                playBackgroundMusic("Remains.mp3")
//            }
//        }
        
        for counter in gametimer{
            if counter.countClick % 2 == 0{
                if ArrayData.maxElement() == nil{
                    self.clvCharacter.hidden = true
                    self.vSetting.hidden = true
                    counterWakeUp = 1.5
                    timer2 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(countDown), userInfo: nil, repeats: true)
                    return
                }
                
            }else{
                if ArrayData.maxElement() == nil{
                    self.clvCharacter.hidden = true
                    self.vSetting.hidden = true
                    counterWakeUp = 3
                    timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(countDown2), userInfo: nil, repeats: true)
                    return
                }
                
            }
            
        }
        
        let viewwithTag = self.view.viewWithTag(106)
        let viewwithTag1 = self.view.viewWithTag(107)
        if (viewwithTag != nil && viewwithTag1 != nil){
            viewwithTag!.hidden = false
            viewwithTag1!.hidden = false
        }
        
        self.clvCharacter.hidden = true
        self.vSetting.hidden = true
        
        
        counter = 0
        
        playMusic("EveryoneClose.mp3")
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
        
        
    }
    
    func lz(){
        
        if counter == 2 {
            let realm = try! Realm()
            let checkClick = realm.objects(CheckClickSpecialCard)
            let doppelgenger = realm.objects(Doppelganger)
            let werewolf = realm.objects(Werewolf)
            let minion = realm.objects(Minion)
            let mason = realm.objects(Mason)
            let seer = realm.objects(Seer)
            let robber = realm.objects(Robber)
            let troublemaker = realm.objects(Troublemaker)
            let drunk = realm.objects(Drunk)
            let insomiac = realm.objects(Insomniac)
            let villager = realm.objects(Villager)
            let hunter = realm.objects(Hunter)
            let tanner = realm.objects(Tanner)
            
            let viewwithTag = self.view.viewWithTag(106)
            if (viewwithTag != nil){
                viewwithTag!.hidden = true
            }
            timer.invalidate()
            
            if counterNext == 0{
                for person in doppelgenger{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(108)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            doppelgangerSubView.lblText.text = "DOPPELGANGER, wake up and look at another player's card. You are now that role."
                        }
                        for checkclick in checkClick{
                            if checkclick.countClick == 0 {
                                playMusic("DoppelgangerWakeFul.mp3")
                                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount), userInfo: nil, repeats: true)
                            }else{
                                playMusic("DoppelgangerWakeDop.mp3")
                                timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(doppelgangerCountSwitch), userInfo: nil, repeats: true)
                            }
                        }
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 1{
                for person in werewolf{
                    if(person.countClick2 % 2 == 1 && person.countClick % 2 == 1) {
                        let viewwithTag9 = self.view.viewWithTag(109)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            werewolfSubView.lblText.text = "WEREWOLVES, wake up."
                        }
                        playMusic("WereWolvesWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(werewolfCount), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 0 && person.countClick % 2 == 1){
                        let viewwithTag9 = self.view.viewWithTag(109)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            werewolfSubView.lblText.text = "WEREWOLVES, wake up."
                        }
                        playMusic("WereWolvesWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(werewolfCount), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 1 && person.countClick % 2 == 0){
                        let viewwithTag9 = self.view.viewWithTag(109)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            werewolfSubView.lblText.text = "WEREWOLVES, wake up."
                        }
                        playMusic("WereWolvesWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(werewolfCount), userInfo: nil, repeats: true)
                    }else{
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 2{
                for person in minion{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(110)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            minionSubView.lblText.text = "MINION, wake up."
                        }
                        playMusic("MinionWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(minionCount1), userInfo: nil, repeats: true)
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 3{
                for person in mason{
                    if(person.countClick2 % 2 == 1 && person.countClick % 2 == 1) {
                        let viewwithTag9 = self.view.viewWithTag(111)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            masonSubView.lblText.text = "MASONS, wake up."
                        }
                        playMusic("MasonWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(masonCount), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 0 && person.countClick % 2 == 1){
                        let viewwithTag9 = self.view.viewWithTag(111)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            masonSubView.lblText.text = "MASONS, wake up."
                        }
                        playMusic("MasonWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(masonCount), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 1 && person.countClick % 2 == 0){
                        let viewwithTag9 = self.view.viewWithTag(111)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            masonSubView.lblText.text = "MASONS, wake up."
                        }
                        playMusic("MasonWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(masonCount), userInfo: nil, repeats: true)
                    }else{
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 4{
                for person in seer{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(112)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            seerSubView.lblText.text = "SEER, wake up."
                        }
                        playMusic("SeerWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(seerCount1), userInfo: nil, repeats: true)
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 5{
                for person in robber{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(113)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            robberSubView.lblText.text = "ROBBER, wake up."
                        }
                        playMusic("RobberWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(robberCount1), userInfo: nil, repeats: true)
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 6{
                for person in troublemaker{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(114)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            troublemakerSubView.lblText.text = "TROUBLEMAKER, wake up."
                        }
                        playMusic("TroublemakerWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(troublemakerCount1), userInfo: nil, repeats: true)
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 7{
                for person in drunk{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(115)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            drunkSubView.lblText.text = "DRUNK, wake up."
                        }
                        playMusic("DrunkWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(drunkCount1), userInfo: nil, repeats: true)
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 8{
                for person in insomiac{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }else{
                        let viewwithTag9 = self.view.viewWithTag(116)
                        if (viewwithTag9 != nil){
                            viewwithTag9!.hidden = false
                            insomniacSubView.lblText.text = "INSOMNIAC, wake up."
                        }
                        playMusic("InsomniacWake.mp3")
                        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(insomniacCount1), userInfo: nil, repeats: true)
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 9{
                for person in villager{
                    if(person.countClick2 % 2 == 1 && person.countClick3 % 2 == 1 && person.countClick % 2 == 1) {
                        
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 1 && person.countClick3 % 2 == 1 && person.countClick % 2 == 0){
                        
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 1 && person.countClick3 % 2 == 0 && person.countClick % 2 == 1){
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }else if(person.countClick2 % 2 == 1 && person.countClick3 % 2 == 0 && person.countClick % 2 == 0){
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }
                    else if(person.countClick2 % 2 == 0 && person.countClick3 % 2 == 1 && person.countClick % 2 == 0){
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }
                    else if(person.countClick2 % 2 == 0 && person.countClick3 % 2 == 0 && person.countClick % 2 == 1){
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }
                    else if(person.countClick2 % 2 == 0 && person.countClick3 % 2 == 1 && person.countClick % 2 == 1){
                        if ArrayData.maxElement() == 11 || ArrayData.maxElement() == 12 || ArrayData.maxElement() == 13{
                            self.everyoneWakeUp()
                        }
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }
                    else{
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                        break
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 10{
                for person in hunter{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }else{
                        
                            if ArrayData.maxElement() == 14 {
                                self.everyoneWakeUp()
                            }
                        
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
                
            else if counterNext == 11{
                for person in tanner{
                    if(person.countClick % 2 == 0){
                        timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
                    }else{
                        
                            if ArrayData.maxElement() == 15 {
                                self.everyoneWakeUp()
                                break
                            }
                        
                    }
                }
                counterNext += 1
                print("CounterNext: \(counterNext)")
            }
            
            counter = 2
            return
        }
        counter += 1
    }
    
    func doppelgangerCountSwitch(){
        if counterDoppelganger == 7.5{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "If you viewed the Seer, Robber, Troublemaker or Drunk card, do your action now."
            playMusic("DoppelgangerWakeIf.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(doppelgangerCountSwitch2), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 0.5
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCountSwitch2(){
        if counterDoppelganger == 0.5{
            playMusic("DoppelgangerWakeSeer.mp3")
        }
        else if counterDoppelganger == 1.5{
            playMusic("DoppelgangerWakeRobber.mp3")
        }
        else if counterDoppelganger == 2.5{
            playMusic("DoppelgangerWakeTroublemaker.mp3")
        }
        else if counterDoppelganger == 3.5{
            playMusic("DoppelgangerWakeOr.mp3")
        }
        else if counterDoppelganger == 4.5{
            playMusic("DoppelgangerWakeDrunk.mp3")
        }
        else if counterDoppelganger == 5{
            playMusic("DoppelgangerWakeDo.mp3")
        }
        else if counterDoppelganger == 7.5{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "(PAUSE for 5 seconds)"
            
            let realm = try! Realm()
            let minion = realm.objects(Minion)
            for person in minion{
                if(person.countClick % 2 == 0){
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(doppelgangerCount6), userInfo: nil, repeats: true)
                }else{
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount3), userInfo: nil, repeats: true)
                }
            }
            return
        }
        counterDoppelganger += 0.5
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount(){
        if counterDoppelganger == 7{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = " If your new role has a night action, do it now."
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount2), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 1
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount2(){
        if counterDoppelganger == 3{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "(PAUSE for 5 seconds)"
            
            let realm = try! Realm()
            let minion = realm.objects(Minion)
            for person in minion{
                if(person.countClick % 2 == 0){
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount6), userInfo: nil, repeats: true)
                }else{
                    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount3), userInfo: nil, repeats: true)
                }
            }
            return
        }
        counterDoppelganger += 1
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount3(){
        if counterDoppelganger == 5{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "If you are now a Minion, keep your eyes open. Otherwisem close them. Werewolves, stick our your thumb so the Doppelganger-Minion can see who you are"
            playMusic("DoppelgangerMinion.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount4), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 1
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount4(){
        if counterDoppelganger == 11{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(doppelgangerCount5), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 1
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount5(){
        if counterDoppelganger == 5{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "WEREWOLVES, put your thumb away."
            playMusic("WereWolvesPut.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(doppelgangerCount7), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 1
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount7(){
        if counterDoppelganger == 3{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "DOPPELGANGER, close your eyes"
            playMusic("DoppelgangerClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(doppelgangerBreak), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 0.5
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerCount6(){
        if counterDoppelganger == 5{
            timer.invalidate()
            counterDoppelganger = 0
            doppelgangerSubView.lblText.text = "DOPPELGANGER, close your eyes"
            playMusic("DoppelgangerClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(doppelgangerBreak), userInfo: nil, repeats: true)
            return
        }
        counterDoppelganger += 0.5
        print("Doppelganger: \(counterDoppelganger)")
    }
    
    func doppelgangerBreak(){
        if counterDoppelganger == 2.5 {
            timer.invalidate()
            counterDoppelganger = 0
            let viewwithTag1 = self.view.viewWithTag(108)
            if (viewwithTag1 != nil){
                
                
                    if ArrayData.maxElement() == 0{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterDoppelganger += 0.5
    }
    
    //
    func werewolfCount(){
        if counterWereWolf == 1.5{
            musicPlayer.stop()
        }
         else if counterWereWolf == 2{
            timer.invalidate()
            counterWereWolf = 0
            werewolfSubView.lblText.text = "If there is only one Werewolf, you may look at a card from the center."
            playMusic("WereWolvesIf.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(werewolfCount1), userInfo: nil, repeats: true)
            return
        }
        counterWereWolf += 0.5
        print("WereWolf: \(counterWereWolf)")
    }
    
    func werewolfCount1(){
        if counterWereWolf == 4{
            timer.invalidate()
            counterWereWolf = 0
            werewolfSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(werewolfCount2), userInfo: nil, repeats: true)
            return
        }
        counterWereWolf += 0.5
        print("WereWolf: \(counterWereWolf)")
    }
    
    func werewolfCount2(){
        if counterWereWolf == 5{
            timer.invalidate()
            counterWereWolf = 0
            werewolfSubView.lblText.text = "WEREWOLVES, close your eyes"
            playMusic("WereWolvesClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(werewolfBreak), userInfo: nil, repeats: true)
            return
        }
        counterWereWolf += 1
        print("WereWolf: \(counterWereWolf)")
    }
    
    func werewolfBreak(){
        if counterWereWolf == 2.5 {
            timer.invalidate()
            counterWereWolf = 0
            let viewwithTag1 = self.view.viewWithTag(109)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 1 || ArrayData.maxElement() == 2{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterWereWolf += 0.5
    }
    
    func minionCount(){
        if counterMinion == 2{
            timer.invalidate()
            counterMinion = 0
            minionSubView.lblText.text = "Werewolves, stick our your thumb so the Minion can see who you are"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(minionCount1), userInfo: nil, repeats: true)
            return
        }
        counterMinion += 0.5
        print("Minion: \(counterMinion)")
    }
    
    func minionCount1(){
        if counterMinion == 1.5 {
            musicPlayer.stop()
        }
        else if counterMinion == 2{
            timer.invalidate()
            counterMinion = 0
            minionSubView.lblText.text = "(PAUSE for 5 seconds.)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(minionCount2), userInfo: nil, repeats: true)
            return
        }
        counterMinion += 0.5
        print("Minion: \(counterMinion)")
    }
    
    func minionCount2(){
        if counterMinion == 5{
            timer.invalidate()
            counterMinion = 0
            minionSubView.lblText.text = "Minion, close your eyes."
            playMusic("MinionClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(minionBreak), userInfo: nil, repeats: true)
            return
        }
        counterMinion += 1
        print("Minion: \(counterMinion)")
    }
    
    func minionBreak(){
        if counterMinion == 2.5 {
            timer.invalidate()
            counterMinion = 0
            let viewwithTag1 = self.view.viewWithTag(110)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 3{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterMinion += 0.5
    }
    
    //
    
    func masonCount(){
        if counterMason == 1.5{
            musicPlayer.stop()
        }
        else if counterMason == 2{
            timer.invalidate()
            counterMason = 0
            masonSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(masonCount1), userInfo: nil, repeats: true)
            return
        }
        counterMason += 0.5
        print("Mason: \(counterMason)")
    }
    
    func masonCount1(){
        if counterMason == 5{
            timer.invalidate()
            counterMason = 0
            masonSubView.lblText.text = "MASONS, close your eyes"
            playMusic("MasonClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(masonBreak), userInfo: nil, repeats: true)
            return
        }
        counterMason += 1
        print("Mason: \(counterMason)")
    }
    
    func masonBreak(){
        if counterMason == 2.5 {
            timer.invalidate()
            counterMason = 0
            let viewwithTag1 = self.view.viewWithTag(111)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 4 || ArrayData.maxElement() == 5{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterMason += 0.5
    }
    
    ///
    
    
    func seerCount1(){
        if counterSeer == 1.5 {
            musicPlayer.stop()
        }
        else if counterSeer == 2{
            timer.invalidate()
            counterSeer = 0
            seerSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(seerCount2), userInfo: nil, repeats: true)
            return
        }
        counterSeer += 0.5
        print("Seer: \(counterSeer)")
    }
    
    func seerCount2(){
        if counterSeer == 5{
            timer.invalidate()
            counterSeer = 0
            seerSubView.lblText.text = "Seer, close your eyes."
            playMusic("SeerClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(seerBreak), userInfo: nil, repeats: true)
            return
        }
        counterSeer += 1
        print("Seer: \(counterSeer)")
    }
    
    func seerBreak(){
        if counterSeer == 2.5 {
            timer.invalidate()
            counterSeer = 0
            let viewwithTag1 = self.view.viewWithTag(112)
            if (viewwithTag1 != nil){
                    if ArrayData.maxElement() == 6{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterSeer += 0.5
    }
    
    ///
    func robberCount1(){
        if counterRobber == 1.5{
            musicPlayer.stop()
        }
        else if counterRobber == 2{
            timer.invalidate()
            counterRobber = 0
            robberSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(robberCount2), userInfo: nil, repeats: true)
            return
        }
        counterRobber += 0.5
        print("Robber: \(counterRobber)")
    }
    
    func robberCount2(){
        if counterRobber == 5{
            timer.invalidate()
            counterRobber = 0
            robberSubView.lblText.text = "Robber, close your eyes."
            playMusic("RobberClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(robberBreak), userInfo: nil, repeats: true)
            return
        }
        counterRobber += 1
        print("Robber: \(counterRobber)")
    }
    
    func robberBreak(){
        if counterRobber == 2.5 {
            timer.invalidate()
            counterRobber = 0
            let viewwithTag1 = self.view.viewWithTag(113)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 7{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterRobber += 0.5
    }
    //
    
    ///
    func troublemakerCount1(){
        if counterTroublemaker == 1.5{
            musicPlayer.stop()
        }
        else if counterTroublemaker == 2{
            timer.invalidate()
            counterTroublemaker = 0
            troublemakerSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(troublemakerCount2), userInfo: nil, repeats: true)
            return
        }
        counterTroublemaker += 0.5
        print("TroubleMaker: \(counterTroublemaker)")
    }
    
    func troublemakerCount2(){
        if counterTroublemaker == 5{
            timer.invalidate()
            counterTroublemaker = 0
            troublemakerSubView.lblText.text = "Troublemaker, close your eyes."
            playMusic("TroublemakerClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(troublemakerBreak), userInfo: nil, repeats: true)
            return
        }
        counterTroublemaker += 1
        print("TroubleMaker: \(counterTroublemaker)")
    }
    
    func troublemakerBreak(){
        if counterTroublemaker == 2.5 {
            timer.invalidate()
            counterTroublemaker = 0
            let viewwithTag1 = self.view.viewWithTag(114)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 8{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterTroublemaker += 0.5
    }
    //
    
    func drunkCount1(){
        if counterDrunk == 1.5{
            musicPlayer.stop()
        }
        else if counterDrunk == 2{
            timer.invalidate()
            counterDrunk = 0
            drunkSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(drunkCount2), userInfo: nil, repeats: true)
            return
        }
        counterDrunk += 0.5
        print("Drunk: \(counterDrunk)")
    }
    
    func drunkCount2(){
        if counterDrunk == 5{
            timer.invalidate()
            counterDrunk = 0
            drunkSubView.lblText.text = "Drunk, close your eyes."
            playMusic("DrunkClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(drunkBreak), userInfo: nil, repeats: true)
            return
        }
        counterDrunk += 1
        print("Drunk: \(counterDrunk)")
    }
    
    func drunkBreak(){
        if counterDrunk == 2.5 {
            timer.invalidate()
            counterDrunk = 0
            let viewwithTag1 = self.view.viewWithTag(115)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 9{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterDrunk += 0.5
    }
    //
    
    func insomniacCount1(){
        if counterInsomniac == 2 {
            musicPlayer.stop()
        }
        else if counterInsomniac == 2.5{
            timer.invalidate()
            counterInsomniac = 0
            insomniacSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(insomniacCount2), userInfo: nil, repeats: true)
            return
        }
        counterInsomniac += 0.5
        print("Insomniac: \(counterInsomniac)")
    }
    
    func insomniacCount2(){
        if counterInsomniac == 5{
            timer.invalidate()
            counterInsomniac = 0
            insomniacSubView.lblText.text = "Insomniac, close your eyes."
            let realm = try! Realm()
            let checkDoppelgangerClick = realm.objects(Doppelganger)
            for checkdoppelganger in checkDoppelgangerClick {
                if checkdoppelganger.countClick % 2 == 0{
                    playMusic("InsomniacClose.mp3")
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(insomniacBreak), userInfo: nil, repeats: true)
                }else{
                    playMusic("InsomniacClose.mp3")
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(DoppelgangerCalled), userInfo: nil, repeats: true)
                }
            }
            return
        }
        counterInsomniac += 1
        print("Insomniac: \(counterInsomniac)")
    }
    
    func DoppelgangerCalled(){
        if counterInsomniac == 3 {
            timer.invalidate()
            counterInsomniac = 0
            let viewwithTag9 = self.view.viewWithTag(108)
            let viewwithTag10 = self.view.viewWithTag(116)
            if (viewwithTag9 != nil){
                viewwithTag9!.hidden = false
                viewwithTag10!.hidden = true
                doppelgangerSubView.lblText.text = "DOPPELGANGER, if you viewed the Insomniac card, wake up"
            }
            playMusic("DoppelgangerAndInso.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(DoppelgangerCalled2), userInfo: nil, repeats: true)
            return
        }
        counterInsomniac += 0.5
        print("Insomniac: \(counterInsomniac)")
    }
    
    func DoppelgangerCalled2(){
        if counterInsomniac == 4.5 {
            musicPlayer.stop()
            timer.invalidate()
            counterInsomniac = 0
            doppelgangerSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(DoppelgangerCalled3), userInfo: nil, repeats: true)
            return
        }
        counterInsomniac += 0.5
        print("Insomniac: \(counterInsomniac)")
    }
    
    func DoppelgangerCalled3(){
        if counterInsomniac == 5 {
            timer.invalidate()
            counterInsomniac = 0
            doppelgangerSubView.lblText.text = "Doppelganger, close your eyes"
            playMusic("DoppelgangerClose.mp3")
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(insomniacBreak), userInfo: nil, repeats: true)
            return
        }
        counterInsomniac += 1
        print("Insomniac: \(counterInsomniac)")
    }
    
    func insomniacBreak(){
        if counterInsomniac == 2.5 {
            timer.invalidate()
            counterInsomniac = 0
            let viewwithTag = self.view.viewWithTag(108)
            let viewwithTag1 = self.view.viewWithTag(116)
            if (viewwithTag1 != nil){
                
                    if ArrayData.maxElement() == 10{
                        self.everyoneWakeUp()
                    }
                
                viewwithTag1!.hidden = true
                viewwithTag!.hidden = true
                counter = 2
                timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector:#selector(lz), userInfo: nil, repeats: true)
            }
            return
        }
        counterInsomniac += 0.5
    }
    //
    
    
    func everyoneWakeUp(){
        let viewwithTag9 = self.view.viewWithTag(117)
        if (viewwithTag9 != nil){
            viewwithTag9!.hidden = false
            wakeupSubView.lblText.text = "EVERYONE, keep your eyes closed, reach out and move your cards around slightly"
        }
        playMusic("EveryoneKeep.mp3")
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(everyoneWakeUp1), userInfo: nil, repeats: true)
    }
    
    func everyoneWakeUp1(){
        if counterWakeUp == 6{
            timer2.invalidate()
            counterWakeUp = 0
            wakeupSubView.lblText.text = "(PAUSE for 5 seconds)"
            timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(everyoneWakeUp2), userInfo: nil, repeats: true)
            return
        }
        counterWakeUp += 0.5
        print("WakeUp1: \(counterWakeUp)")
    }
    
    func everyoneWakeUp2(){
        if counterWakeUp == 5{
            timer2.invalidate()
            counterWakeUp = 0
            wakeupSubView.lblText.text = "EVERYONE, wake up!"
            let realm1 = try! Realm()
            let gametimer = realm1.objects(GameTimerClick)
            for person in gametimer{
                if person.countClick % 2 == 0{
                    playMusic("EveryoneWake.mp3")
                    timer2 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(countDown), userInfo: nil, repeats: true)
                }
                else{
                    playMusic("EveryoneWake.mp3")
                    timer2 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:#selector(countDown2timer), userInfo: nil, repeats: true)
                }
            }
            
            return
        }
        counterWakeUp += 1
        print("WakeUp2: \(counterWakeUp)")
    }
    ////
    func countDown(){
        countDownSubView.lblText.text = String(countdown)
        if counterWakeUp == 1.5 {
            timer2.invalidate()
            counterWakeUp = 0
            let viewwithTag9 = self.view.viewWithTag(118)
            let viewwithTag8 = self.view.viewWithTag(117)
            if (viewwithTag9 != nil){
                viewwithTag8!.hidden = true
                viewwithTag9!.hidden = false
                countDownSubView.btnVoteNow.addTarget(self, action: #selector(ViewController.ClickToVoteNow(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                timer3 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(countDown3), userInfo: nil, repeats: true)
            }
            timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(VoteNow), userInfo: nil, repeats: true)
            return
        }
        counterWakeUp += 0.5
        print("WakeUp3: \(counterWakeUp)")
    }
    
    
    func countDown2timer(){
        if counterWakeUp == 2 {
            timer2.invalidate()
            timer3.invalidate()
            backgroundMusicPlayer.stop()
            let viewwithTag = self.view.viewWithTag(106)
            let viewwithTag1 = self.view.viewWithTag(107)
            let viewwithTag2 = self.view.viewWithTag(108)
            let viewwithTag3 = self.view.viewWithTag(109)
            let viewwithTag4 = self.view.viewWithTag(110)
            let viewwithTag5 = self.view.viewWithTag(111)
            let viewwithTag6 = self.view.viewWithTag(112)
            let viewwithTag7 = self.view.viewWithTag(113)
            let viewwithTag8 = self.view.viewWithTag(114)
            let viewwithTag9 = self.view.viewWithTag(115)
            let viewwithTag10 = self.view.viewWithTag(116)
            let viewwithTag11 = self.view.viewWithTag(117)
            let viewwithTag12 = self.view.viewWithTag(118)
            let viewwithTag13 = self.view.viewWithTag(119)
            if (viewwithTag != nil){
                viewwithTag!.hidden = true
                viewwithTag1!.hidden = true
                viewwithTag2!.hidden = true
                viewwithTag3!.hidden = true
                viewwithTag4!.hidden = true
                viewwithTag5!.hidden = true
                viewwithTag6!.hidden = true
                viewwithTag7!.hidden = true
                viewwithTag8!.hidden = true
                viewwithTag9!.hidden = true
                viewwithTag10!.hidden = true
                viewwithTag11!.hidden = true
                viewwithTag12!.hidden = true
                viewwithTag13!.hidden = true
                
            }
            
            self.clvCharacter.hidden = false
            self.vSetting.hidden = false
            counterNext = 0
            counterDoppelganger = 0
            counterWereWolf = 0
            counterMinion = 0
            counterMason = 0
            counterSeer = 0
            counterRobber = 0
            counterTroublemaker = 0
            counterDrunk = 0
            counterInsomniac = 0
            counterVoteView = 0
            
            countdown = 0
            counterWakeUp = 0
            return
        }
        counterWakeUp += 0.5
        print("WakeUp4: \(counterWakeUp)")
    }
    
    
    func countDown2(){
        if counterWakeUp == 5 {
            timer2.invalidate()
            timer3.invalidate()
            backgroundMusicPlayer.stop()
            let viewwithTag = self.view.viewWithTag(106)
            let viewwithTag1 = self.view.viewWithTag(107)
            let viewwithTag2 = self.view.viewWithTag(108)
            let viewwithTag3 = self.view.viewWithTag(109)
            let viewwithTag4 = self.view.viewWithTag(110)
            let viewwithTag5 = self.view.viewWithTag(111)
            let viewwithTag6 = self.view.viewWithTag(112)
            let viewwithTag7 = self.view.viewWithTag(113)
            let viewwithTag8 = self.view.viewWithTag(114)
            let viewwithTag9 = self.view.viewWithTag(115)
            let viewwithTag10 = self.view.viewWithTag(116)
            let viewwithTag11 = self.view.viewWithTag(117)
            let viewwithTag12 = self.view.viewWithTag(118)
            let viewwithTag13 = self.view.viewWithTag(119)
            if (viewwithTag != nil){
                viewwithTag!.hidden = true
                viewwithTag1!.hidden = true
                viewwithTag2!.hidden = true
                viewwithTag3!.hidden = true
                viewwithTag4!.hidden = true
                viewwithTag5!.hidden = true
                viewwithTag6!.hidden = true
                viewwithTag7!.hidden = true
                viewwithTag8!.hidden = true
                viewwithTag9!.hidden = true
                viewwithTag10!.hidden = true
                viewwithTag11!.hidden = true
                viewwithTag12!.hidden = true
                viewwithTag13!.hidden = true
                
            }
            
            self.clvCharacter.hidden = false
            self.vSetting.hidden = false
            counterNext = 0
            counterDoppelganger = 0
            counterWereWolf = 0
            counterMinion = 0
            counterMason = 0
            counterSeer = 0
            counterRobber = 0
            counterTroublemaker = 0
            counterDrunk = 0
            counterInsomniac = 0
            counterVoteView = 0
            
            countdown = 0
            counterWakeUp = 0
            return
        }
        counterWakeUp += 1
        print("WakeUp4: \(counterWakeUp)")
    }
    
    func countDown3(){
        print("CountDown: \(countdown)")
        if countdown == 3 {
            timer3.invalidate()
            return
        }
        countdown += 1
        countDownSubView.lblText.text = String(countdown)
        
    }
    
    
    func ClickToVoteNow(sender:UIButton){
        timer3.invalidate()
        counterVoteView = 4
        self.VoteNow()
    }
    
    //
    func VoteNow(){
        if counterVoteView == 4 {
            timer2.invalidate()
            let viewwithTag = self.view.viewWithTag(106)
            let viewwithTag1 = self.view.viewWithTag(107)
            let viewwithTag2 = self.view.viewWithTag(108)
            let viewwithTag3 = self.view.viewWithTag(109)
            let viewwithTag4 = self.view.viewWithTag(110)
            let viewwithTag5 = self.view.viewWithTag(111)
            let viewwithTag6 = self.view.viewWithTag(112)
            let viewwithTag7 = self.view.viewWithTag(113)
            let viewwithTag8 = self.view.viewWithTag(114)
            let viewwithTag9 = self.view.viewWithTag(115)
            let viewwithTag10 = self.view.viewWithTag(116)
            let viewwithTag11 = self.view.viewWithTag(117)
            let viewwithTag12 = self.view.viewWithTag(118)
            let viewwithTag13 = self.view.viewWithTag(119)
            if (viewwithTag != nil){
                viewwithTag!.hidden = true
                viewwithTag1!.hidden = true
                viewwithTag2!.hidden = true
                viewwithTag3!.hidden = true
                viewwithTag4!.hidden = true
                viewwithTag5!.hidden = true
                viewwithTag6!.hidden = true
                viewwithTag7!.hidden = true
                viewwithTag8!.hidden = true
                viewwithTag9!.hidden = true
                viewwithTag10!.hidden = true
                viewwithTag11!.hidden = true
                viewwithTag12!.hidden = true
                viewwithTag13!.hidden = false
                playMusic("Vote.mp3")
                timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:#selector(countDown2), userInfo: nil, repeats: true)
            }
        }
        counterVoteView += 1
        print("VoteView: \(counterVoteView)")
    }
    
    //setDoppelganger
    func setDoppelganger(){
        doppelgangerSubView = DoppelgangerView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        doppelgangerSubView.tag = 108
        self.vContact.addSubview(doppelgangerSubView)
    }
    
    //setWereWolf
    func setWereWolf(){
        werewolfSubView = WerewolfView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        werewolfSubView.tag = 109
        self.vContact.addSubview(werewolfSubView)
    }
    
    //setMinion
    func setMinion(){
        minionSubView = MinionView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        minionSubView.tag = 110
        self.vContact.addSubview(minionSubView)
    }
    
    //setMason
    func setMason(){
        masonSubView = MasonView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        masonSubView.tag = 111
        self.vContact.addSubview(masonSubView)
    }
    
    //setSeer
    func setSeer(){
        seerSubView = SeerView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        seerSubView.tag = 112
        self.vContact.addSubview(seerSubView)
    }
    
    //setRobber
    func setRobber(){
        robberSubView = RobberView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        robberSubView.tag = 113
        self.vContact.addSubview(robberSubView)
    }
    
    //setTroublemaker
    func setTroublemaker(){
        troublemakerSubView = TroublemakerView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        troublemakerSubView.tag = 114
        self.vContact.addSubview(troublemakerSubView)
    }
    
    //setDrunk
    func setDrunk(){
        drunkSubView = DrunkView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        drunkSubView.tag = 115
        self.vContact.addSubview(drunkSubView)
    }
    
    //setInsomniac
    func setInsomniac(){
        insomniacSubView = InsomniacView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        insomniacSubView.tag = 116
        self.vContact.addSubview(insomniacSubView)
    }
    
    //setWakeUp
    func setWakeUp(){
        wakeupSubView = WakeUpView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        wakeupSubView.tag = 117
        self.vContact.addSubview(wakeupSubView)
    }
    
    //setCountDown
    func setCountDown(){
        countDownSubView = CountDownView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        countDownSubView.tag = 118
        self.vContact.addSubview(countDownSubView)
    }
    
    //setVoteView
    func setVoteView(){
        vote = VoteView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        vote.tag = 119
        self.vContact.addSubview(vote)
    }
    
    
    //setStoryTelling
    func setStoryTelling(){
        let storytellingSubVIew:StoryTelling = StoryTelling(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        storytellingSubVIew.tag = 106
        self.vContact.addSubview(storytellingSubVIew)
        
        let stopandpauseSubView:StopAndPauseView = StopAndPauseView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
        stopandpauseSubView.btnPause.addTarget(self, action: #selector(ViewController.PauseTelling(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        stopandpauseSubView.btnStop.addTarget(self, action: #selector(ViewController.StopTelling(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        stopandpauseSubView.tag = 107
        self.vContain.addSubview(stopandpauseSubView)
    }
    
    func StopTelling(sender:UIButton){
        backgroundMusicPlayer.stop()
        let viewwithTag = self.view.viewWithTag(106)
        let viewwithTag1 = self.view.viewWithTag(107)
        let viewwithTag2 = self.view.viewWithTag(108)
        let viewwithTag3 = self.view.viewWithTag(109)
        let viewwithTag4 = self.view.viewWithTag(110)
        let viewwithTag5 = self.view.viewWithTag(111)
        let viewwithTag6 = self.view.viewWithTag(112)
        let viewwithTag7 = self.view.viewWithTag(113)
        let viewwithTag8 = self.view.viewWithTag(114)
        let viewwithTag9 = self.view.viewWithTag(115)
        let viewwithTag10 = self.view.viewWithTag(116)
        let viewwithTag11 = self.view.viewWithTag(117)
        let viewwithTag12 = self.view.viewWithTag(118)
        let viewwithTag13 = self.view.viewWithTag(119)
        if (viewwithTag != nil){
            viewwithTag!.hidden = true
            viewwithTag1!.hidden = true
            viewwithTag2!.hidden = true
            viewwithTag3!.hidden = true
            viewwithTag4!.hidden = true
            viewwithTag5!.hidden = true
            viewwithTag6!.hidden = true
            viewwithTag7!.hidden = true
            viewwithTag8!.hidden = true
            viewwithTag9!.hidden = true
            viewwithTag10!.hidden = true
            viewwithTag11!.hidden = true
            viewwithTag12!.hidden = true
            viewwithTag13!.hidden = true
            
        }
        
        self.clvCharacter.hidden = false
        self.vSetting.hidden = false
        counterNext = 0
        counterDoppelganger = 0
        counterWereWolf = 0
        counterMinion = 0
        counterMason = 0
        counterSeer = 0
        counterRobber = 0
        counterTroublemaker = 0
        counterDrunk = 0
        counterInsomniac = 0
        counterVoteView = 0
        
        countdown = 0
        counterWakeUp = 0
        
        timer.invalidate()
        timer2.invalidate()
        timer3.invalidate()
        return
        
    }
    
    func PauseTelling(sender:UIButton){
        if i%2==0{
            backgroundMusicPlayer.pause()
        }else{
            backgroundMusicPlayer.play()
        }
        i += 1
    }
    
    //setSetting
    func setSettingButton(){
        self.view.layoutIfNeeded()
        let settingSubView:SettingView = SettingView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        settingSubView.tag = 100
        settingSubView.btnEditNarration.addTarget(self, action: #selector(ViewController.ClickEditNarration(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        settingSubView.btnEditGameTimer.addTarget(self, action: #selector(ViewController.ClickEditGameTimer(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        settingSubView.btnEditRoleTimer.addTarget(self, action: #selector(ViewController.ClickEditRoleTimer(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        settingSubView.btnEditOther.addTarget(self, action: #selector(ViewController.ClickEditOther(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.vContact.addSubview(settingSubView)
        
        let backSubView:BackView = BackView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
        backSubView.btnBack.addTarget(self, action: #selector(ViewController.ReleadSubView(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backSubView.btnHelp.addTarget(self, action: #selector(ViewController.HelpFunction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backSubView.tag = 101
        self.vContain.addSubview(backSubView)
    }
    
    //click setting button
    @IBAction func ClickSetting(sender: AnyObject) {
        
        let viewwithTag3 = self.view.viewWithTag(100)
        let viewwithTag4 = self.view.viewWithTag(101)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = false
            viewwithTag4!.hidden = false
        }
        self.vSetting.hidden = true
        self.clvCharacter.hidden = true
        
    }
    
    func ClickNarration(sender:UIButton) {
        print("ccc")
    }
    
    //set NarrationButton
    func setNarrationButton(){
        let narrationSubView:NarrationView = NarrationView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        narrationSubView.tag = 104
        narrationSubView.btnUp.addTarget(self, action: #selector(ViewController.RaiseVolume(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        narrationSubView.btnDown.addTarget(self, action: #selector(ViewController.DownVolume(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.vContact.addSubview(narrationSubView)
        
        let backHelpSubView:BackHelpView = BackHelpView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
        backHelpSubView.btnBack.addTarget(self, action: #selector(ViewController.ReleadSubView4(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backHelpSubView.btnMain.addTarget(self, action: #selector(ViewController.ReleadSubView5(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backHelpSubView.tag = 105
        self.vContain.addSubview(backHelpSubView)
    }
    
    func RaiseVolume(sender:UIButton){
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(VolumeBackGround)
        try! realm1.write{
            for person in allPeople1{
                person.Volume += 0.1
                if person.Volume > 1{
                    person.Volume = 1
                    return
                }
            }
        }
    }
    
    func DownVolume(sender:UIButton){
        let realm1 = try! Realm()
        let allPeople1 = realm1.objects(VolumeBackGround)
        try! realm1.write{
            for person in allPeople1{
                person.Volume -= 0.1
                if person.Volume < 0{
                    person.Volume = 0
                    return
                }
            }
        }
    }
    
    //Click to edit Narration
    func ClickEditNarration(sender:UIButton){
        print("ccc")
        let viewwithTag = self.view.viewWithTag(100)
        let viewwithTag2 = self.view.viewWithTag(101)
        if (viewwithTag != nil && viewwithTag2 != nil){
            viewwithTag!.hidden = true
            viewwithTag2!.hidden = true
        }
        
        let viewwithTag3 = self.view.viewWithTag(104)
        let viewwithTag4 = self.view.viewWithTag(105)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = false
            viewwithTag4!.hidden = false
        }
        
    }
    
    
    ////Click to edit Gametimer
    //    func ClickEditGameTimer(sender:UIButton){
    //        print("ccc")
    //        let viewwithTag = self.view.viewWithTag(100)
    //        let viewwithTag2 = self.view.viewWithTag(101)
    //        if (viewwithTag != nil && viewwithTag2 != nil){
    //            viewwithTag!.removeFromSuperview()
    //            viewwithTag2!.removeFromSuperview()
    //        }
    //        let gametimerSubView:GameTimerView = GameTimerView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
    //        gametimerSubView.tag = 104
    //        self.vContact.addSubview(gametimerSubView)
    //
    //        let backHelpSubView:BackHelpView = BackHelpView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
    //
    //        backHelpSubView.btnBack.addTarget(self, action: #selector(ViewController.ReleadSubView4(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //        backHelpSubView.btnMain.addTarget(self, action: #selector(ViewController.ReleadSubView5(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //        backHelpSubView.tag = 105
    //        self.vContain.addSubview(backHelpSubView)
    //    }
    //
    ////Click to edit RoleTimer
    //    func ClickEditRoleTimer(sender:UIButton){
    //        print("ccc")
    //        let viewwithTag = self.view.viewWithTag(100)
    //        let viewwithTag2 = self.view.viewWithTag(101)
    //        if (viewwithTag != nil && viewwithTag2 != nil){
    //            viewwithTag!.removeFromSuperview()
    //            viewwithTag2!.removeFromSuperview()
    //        }
    //        let roletimerSubView:RoleTimerView = RoleTimerView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
    //        roletimerSubView.tag = 104
    //        self.vContact.addSubview(roletimerSubView)
    //
    //        let backHelpSubView:BackHelpView = BackHelpView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
    //
    //        backHelpSubView.btnBack.addTarget(self, action: #selector(ViewController.ReleadSubView4(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //        backHelpSubView.btnMain.addTarget(self, action: #selector(ViewController.ReleadSubView5(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //        backHelpSubView.tag = 105
    //        self.vContain.addSubview(backHelpSubView)
    //    }
    //
    //    //Click to edit Other
    //    func ClickEditOther(sender:UIButton){
    //        print("ccc")
    //        let viewwithTag = self.view.viewWithTag(100)
    //        let viewwithTag2 = self.view.viewWithTag(101)
    //        if (viewwithTag != nil && viewwithTag2 != nil){
    //            viewwithTag!.hidden = true
    //            viewwithTag2!.hidden = true
    //        }
    //        let otherSubView:OtherView = OtherView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
    //        otherSubView.tag = 104
    //        self.vContact.addSubview(otherSubView)
    //
    //        let backHelpSubView:BackHelpView = BackHelpView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
    //
    //        backHelpSubView.btnBack.addTarget(self, action: #selector(ViewController.ReleadSubView4(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //        backHelpSubView.btnMain.addTarget(self, action: #selector(ViewController.ReleadSubView5(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    //        backHelpSubView.tag = 105
    //        self.vContain.addSubview(backHelpSubView)
    //    }
    
    //set HelpButton
    func setHelpButton(){
        let helpSubView:HelpView = HelpView(frame:CGRect(x: self.vContact.bounds.origin.x,y: self.vContact.bounds.origin.y,width: self.vContact.bounds.size.width,height: self.vContact.bounds.size.height))
        helpSubView.tag = 102
        self.vContact.addSubview(helpSubView)
        
        let backHelpSubView:BackHelpView = BackHelpView(frame:CGRect(x: self.vSetting.bounds.origin.x,y: self.vSetting.bounds.origin.y,width: self.vSetting.bounds.size.width,height: self.vSetting.bounds.size.height))
        
        backHelpSubView.btnBack.addTarget(self, action: #selector(ViewController.ReleadSubView2(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backHelpSubView.btnMain.addTarget(self, action: #selector(ViewController.ReleadSubView3(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        backHelpSubView.tag = 103
        self.vContain.addSubview(backHelpSubView)
    }
    
    //Click to Help button
    func HelpFunction(sender:UIButton) {
        let viewwithTag = self.view.viewWithTag(100)
        let viewwithTag2 = self.view.viewWithTag(101)
        if (viewwithTag != nil && viewwithTag2 != nil){
            viewwithTag!.hidden = true
            viewwithTag2!.hidden = true
        }
        
        let viewwithTag3 = self.view.viewWithTag(102)
        let viewwithTag4 = self.view.viewWithTag(103)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = false
            viewwithTag4!.hidden = false
        }
        
    }
    
    // Remove SubView
    
    func ReleadSubView(sender:UIButton){
        
        self.clvCharacter.hidden = false
        self.vSetting.hidden = false
        let viewwithTag = self.view.viewWithTag(100)
        let viewwithTag2 = self.view.viewWithTag(101)
        if (viewwithTag != nil && viewwithTag2 != nil){
            viewwithTag!.hidden = true
            viewwithTag2!.hidden = true
        }
    }
    
    
    func ReleadSubView2(sender:UIButton){
        let viewwithTag3 = self.view.viewWithTag(102)
        let viewwithTag4 = self.view.viewWithTag(103)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = true
            viewwithTag4!.hidden = true
        }
        
        let viewwithTag = self.view.viewWithTag(100)
        let viewwithTag2 = self.view.viewWithTag(101)
        if (viewwithTag != nil && viewwithTag2 != nil){
            viewwithTag!.hidden = false
            viewwithTag2!.hidden = false
        }
    }
    
    func ReleadSubView3(sender:UIButton){
        self.clvCharacter.hidden = false
        self.vSetting.hidden = false
        let viewwithTag = self.view.viewWithTag(102)
        let viewwithTag2 = self.view.viewWithTag(103)
        if (viewwithTag != nil && viewwithTag2 != nil){
            viewwithTag!.hidden = true
            viewwithTag2!.hidden = true
        }
    }
    
    func ReleadSubView4(sender:UIButton){
        let viewwithTag3 = self.view.viewWithTag(104)
        let viewwithTag4 = self.view.viewWithTag(105)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = true
            viewwithTag4!.hidden = true
        }
        
        let viewwithTag = self.view.viewWithTag(100)
        let viewwithTag2 = self.view.viewWithTag(101)
        if (viewwithTag != nil && viewwithTag2 != nil){
            viewwithTag!.hidden = false
            viewwithTag2!.hidden = false
        }
    }
    
    func ReleadSubView5(sender:UIButton){
        self.clvCharacter.hidden = false
        self.vSetting.hidden = false
        let viewwithTag3 = self.view.viewWithTag(104)
        let viewwithTag4 = self.view.viewWithTag(105)
        if (viewwithTag3 != nil && viewwithTag4 != nil){
            viewwithTag3!.hidden = true
            viewwithTag4!.hidden = true
        }
    }
}

