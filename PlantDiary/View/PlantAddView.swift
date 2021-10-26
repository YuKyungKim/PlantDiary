//
//  PlantAddView.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/26.
//

import UIKit

class PlantAddView: UIView {
    
    lazy var imageAddView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return imageView
    }()
    
    lazy var imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("이미지 선택", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return button
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름 *"
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var birthView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생일"
        return label
    }()
    
    lazy var birthTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(self.imageAddView)
        self.imageAddView.snp.makeConstraints { (make) in
            make.width.height.equalTo(160)
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
        }
        
        self.imageAddView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.imageAddView)
        }
        
        self.addSubview(self.imageButton)
        self.imageButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageAddView.snp.bottom).offset(8)
            make.centerX.equalTo(self)
            make.height.equalTo(32)
        }
        
        self.addSubview(self.nameView)
        self.nameView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageButton.snp.bottom).offset(16)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.height.equalTo(30)
        }
        
        self.nameView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.nameView)
            make.width.equalTo(48)
        }
        
        self.nameView.addSubview(self.nameTextField)
        self.nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.right).offset(8)
            make.top.bottom.equalTo(self.nameView)
            make.right.equalTo(self.nameView.snp.right)
        }
        
        self.addSubview(self.birthView)
        self.birthView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameView.snp.bottom).offset(8)
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-16)
            make.height.equalTo(30)
        }
        
        self.birthView.addSubview(self.birthLabel)
        self.birthLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.birthView)
            make.width.equalTo(48)
        }
        
        self.birthView.addSubview(self.birthTextField)
        self.birthTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.birthLabel.snp.right).offset(8)
            make.top.bottom.equalTo(self.birthView)
            make.right.equalTo(self.birthView.snp.right)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
