//
//  Plant.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import UIKit
import RealmSwift

class Plant: Object {
    @Persisted(primaryKey: true) var plantID: String
    @Persisted var name: String
    @Persisted var createdAt: Date
    @Persisted var fileName: String?
    @Persisted var birthAt: Date?
    @Persisted var lastWaterAt: Date?
    @Persisted var lastFertilizerAt: Date?
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.createdAt = Date()
        self.plantID = UUID().uuidString
    }
}
