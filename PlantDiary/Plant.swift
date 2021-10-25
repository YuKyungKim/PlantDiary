//
//  Plant.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import UIKit

class Plant: NSObject {
    var name: String
    var createdAt: Date
    var imageUrl: String?
    var birthAt: Date?
    var lastWaterAt: Date?
    var lastFertilizerAt: Date?
    
    required init(name: String) {
        self.name = name
        self.createdAt = Date()
    }
}
