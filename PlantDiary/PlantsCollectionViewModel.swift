//
//  PlantsCollectionViewModel.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import UIKit

class PlantsCollectionViewModel {
    let plant: Plant
    
    init(_ plant: Plant) {
        self.plant = plant
    }
    
    var name: String {
        return plant.name
    }
    
    var image: UIImage? {
        return UIImage(named: "image_plant_dummy") // @TODO: 실제 이미지로 변경
    }
    
    var waterString: NSAttributedString? {
        if let lastWaterAt = plant.lastWaterAt {
            let waterImage = NSTextAttachment()
            waterImage.image = UIImage(named: "icon_water")
            waterImage.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            let passedDay = -Int(lastWaterAt.timeIntervalSinceNow / (60 * 60 * 24))
            
            let waterString = NSMutableAttributedString(attachment: waterImage)
            waterString.append(NSAttributedString(string: " + \(passedDay)"))
            
            return waterString
        }
        
        return nil
    }
    
    var fertString: NSAttributedString? {
        if let lastFertAt = plant.lastFertilizerAt {
            let fertImage = NSTextAttachment()
            fertImage.image = UIImage(named: "icon_fertilizer")
            fertImage.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            let passedDay = -Int(lastFertAt.timeIntervalSinceNow / (60 * 60 * 24))
            
            let fertString = NSMutableAttributedString(attachment: fertImage)
            fertString.append(NSAttributedString(string: " + \(passedDay)"))
            
            return fertString
        }
        
        return nil
    }
    
    var birthString: NSAttributedString? {
        if let birthAt = plant.birthAt {
            let sproutImage = NSTextAttachment()
            sproutImage.image = UIImage(named: "icon_sprout")
            sproutImage.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            let passedDay = -Int(birthAt.timeIntervalSinceNow / (60 * 60 * 24))
            
            let birthString = NSMutableAttributedString(attachment: sproutImage)
            birthString.append(NSAttributedString(string: " + \(passedDay)"))
            
            return birthString
        }
        
        return nil
    }
    
    var statusString: NSAttributedString {
        let statusString = NSMutableAttributedString()
        if let waterString = waterString {
            statusString.append(waterString)
            statusString.append(NSAttributedString(string: "\n"))
        }
        
        if let fertString = fertString {
            statusString.append(fertString)
            statusString.append(NSAttributedString(string: "\n"))
        }
        
        if let birthString = birthString {
            statusString.append(birthString)
            statusString.append(NSAttributedString(string: "\n"))
        }
        
        return statusString
    }
    
    func configure(_ view: PlantsCollectionViewCell) {
        view.nameLabel.text = name
        view.thumbImageView.image = image
        view.statusLabel.attributedText = statusString
    }
}
