//
//  PlantAddViewModel.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/26.
//

import UIKit
import RxSwift
import RxCocoa

class PlantAddViewModel {
    var name = BehaviorRelay<String?>(value: "")
    var birthDay = BehaviorRelay<Date?>(value: nil)
    
    var isValidName: Observable<Bool> {
        return self.name.map { (name) -> Bool in
            if let name = name, name != "" {
                return true
            } else {
                return false
            }
        }
    }
    
    func resetBirthDay() {
        self.birthDay.accept(nil)
    }
}
