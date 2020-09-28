//
//  ItemModel.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/26.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import Foundation
import RealmSwift

class TableItem: Object {
    @objc dynamic var date = String()
    @objc dynamic var progress = String()
    @objc dynamic var target = String()
}
