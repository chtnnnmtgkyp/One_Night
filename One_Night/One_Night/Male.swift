//
//  Male.swift
//  One_Night
//
//  Created by bui manh tri on 7/13/16.
//  Copyright © 2016 TriBM. All rights reserved.
//

import UIKit
import RealmSwift

class Male: Object {
    dynamic var changeValue = 0
    dynamic var countClick = 0
    override class func primaryKey() -> String {
        return "changeValue"
    }
}
