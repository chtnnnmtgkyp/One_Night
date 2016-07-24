//
//  VolumeLabel.swift
//  One_Night
//
//  Created by bui manh tri on 7/14/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit
import RealmSwift

class VolumeLabel: Object {
    dynamic var changeValue = 0
    dynamic var Volume = 0
    override class func primaryKey() -> String {
        return "changeValue"
    }
}
