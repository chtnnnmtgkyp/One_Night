//
//  CountDownView.swift
//  One_Night
//
//  Created by bui manh tri on 7/19/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit

class CountDownView: UIView {

    @IBOutlet var lblText: UILabel!
    
    @IBOutlet var btnVoteNow: UIButton!
    
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
        self.lblText.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.lblText.numberOfLines = 6
        self.btnVoteNow.layer.cornerRadius = self.btnVoteNow.frame.size.height/3
        self.btnVoteNow.layer.masksToBounds = true
        self.btnVoteNow.layer.borderWidth = 1.7
        self.btnVoteNow.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "CountDownView", bundle:bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    

}
