//
//  PlantAddViewController.swift
//  PlantDiary
//
//  Created by 김유경 on 2021/10/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PlantAddViewController: UIViewController {

    lazy var imageAddView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_image")
        return imageView
    }()
    
    lazy var imageButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
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
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "식물 등록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        
        self.setView()
        self.rxBind()
    }
    
    func setView() {
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.imageAddView)
        self.imageAddView.snp.makeConstraints { (make) in
            make.width.height.equalTo(160)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
        }
        
        self.imageAddView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.imageAddView)
        }
        
        self.imageAddView.addSubview(self.imageButton)
        self.imageButton.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self.imageAddView)
        }
        
        self.view.addSubview(self.nameView)
        self.nameView.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageAddView.snp.bottom).offset(16)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
            make.height.equalTo(30)
        }
        
        self.nameView.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.nameView)
            make.width.equalTo(40)
        }
        
        self.nameView.addSubview(self.nameTextField)
        self.nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.right).offset(8)
            make.top.bottom.equalTo(self.nameView)
            make.right.equalTo(self.nameView.snp.right)
        }
        
        self.view.addSubview(self.birthView)
        self.birthView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameView.snp.bottom).offset(8)
            make.left.equalTo(self.view).offset(16)
            make.right.equalTo(self.view).offset(-16)
            make.height.equalTo(30)
        }
        
        self.birthView.addSubview(self.birthLabel)
        self.birthLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.birthView)
            make.width.equalTo(40)
        }
        
        self.birthView.addSubview(self.birthTextField)
        self.birthTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.birthLabel.snp.right).offset(8)
            make.top.bottom.equalTo(self.birthView)
            make.right.equalTo(self.birthView.snp.right)
        }
    }
    
    func rxBind() {
        self.imageButton.rx.tap
            .bind {
                
            }
            .disposed(by: self.disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
