//
//  BackHelpView.swift
//  One_Night
//
//  Created by bui manh tri on 7/11/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit

class BackHelpView: UIView {

    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var btnMain: UIButton!
    
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
        self.btnBack.layer.cornerRadius = self.btnBack.frame.size.height/3
        self.btnBack.layer.masksToBounds = true
        self.btnBack.layer.borderWidth = 1.7
        self.btnBack.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.btnMain.layer.cornerRadius = self.btnMain.frame.size.height/3
        self.btnMain.layer.masksToBounds = true
        self.btnMain.layer.borderWidth = 1.7
        self.btnMain.layer.borderColor = UIColor.whiteColor().CGColor
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "BackHelpView", bundle:bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }

}
