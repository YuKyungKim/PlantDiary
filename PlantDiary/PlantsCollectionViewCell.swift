//
//  PlantsCollectionViewCell.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import Foundation
import UIKit
import SnapKit

class PlantsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlantsCollectionViewCell"
    
    var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    var plant: Plant? {
        didSet {
            bind(plant: plant)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.thumbImageView.image = UIImage(named: "image_plant_dummy")
        
        self.configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func configure() {
        
        contentView.addSubview(thumbImageView)
        thumbImageView.addSubview(dimView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        
        thumbImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(contentView)
        }
        dimView.snp.makeConstraints { (make) in
            make.top.bottom.height.width.equalTo(thumbImageView)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-8)
            make.height.equalTo(20)
        }
        statusLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView).offset(8)
            make.bottom.lessThanOrEqualTo(thumbImageView)
        }
    }
    
    private func bind(plant: Plant?) {
        if let plant = plant {
            self.nameLabel.text = plant.name
            
            if let imageUrl = plant.imageUrl {
                // @TODO: image set
            }
            
            let attributedString = NSMutableAttributedString()
            
            let waterImage = NSTextAttachment()
            waterImage.image = UIImage(named: "icon_water")
            waterImage.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            let waterString = NSMutableAttributedString(attachment: waterImage)
            waterString.append(NSAttributedString(string: " + 4"))
            
            attributedString.append(waterString)
            attributedString.append(NSAttributedString(string: "\n"))
            
            let fertImage = NSTextAttachment()
            fertImage.image = UIImage(named: "icon_fertilizer")
            fertImage.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            let fertString = NSMutableAttributedString(attachment: fertImage)
            fertString.append(NSAttributedString(string: " + 4"))
            
            attributedString.append(fertString)
            
            self.statusLabel.attributedText = attributedString
        }
    }
}
