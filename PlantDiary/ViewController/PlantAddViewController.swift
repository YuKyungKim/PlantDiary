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
import RealmSwift

class PlantAddViewController: UIViewController {

    lazy var plantAddView: PlantAddView = {
        let plantAddView = PlantAddView(frame: self.view.frame)
        return plantAddView
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onClickSave(_:)))
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel = PlantAddViewModel()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "식물 등록"
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.setView()
        self.rxBind()
    }
    
    func setView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.plantAddView)
        self.plantAddView.datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    func rxBind() {
        
        self.plantAddView.nameTextField.rx.text.subscribe { (name) in
            self.viewModel.name.accept(name)
        }
        .disposed(by: disposeBag)

        self.viewModel.isValidName.bind { (isValid) in
            self.saveButton.isEnabled = isValid
        }
        .disposed(by: disposeBag)
        
        self.viewModel.birthDay.bind { (birthDay) in
            if let date = birthDay {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.locale = Locale(identifier: "ko-KR")
                self.plantAddView.birthLabel.text = dateFormatter.string(from: date)
            }
        }
        .disposed(by: disposeBag)
        
        self.plantAddView.imageButton.rx.tap
            .bind { _ in
                let alert = UIAlertController(title: "이미지 선택", message: nil, preferredStyle: .actionSheet)

                let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.sourceType = .camera
                        imagePicker.allowsEditing = true
                        imagePicker.delegate = self
                        self.present(imagePicker, animated: true, completion: nil)
                    } else {
                        // @TODO: 카메라 권한 요청
                    }
                }

                let gallery = UIAlertAction(title: "갤러리", style: .default) { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.sourceType = .photoLibrary
                        imagePicker.allowsEditing = true
                        imagePicker.delegate = self
                        self.present(imagePicker, animated: true, completion: nil)
                    } else {
                        // @TODO: 갤러리 권한 요청
                    }
                }

                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

                alert.addAction(camera)
                alert.addAction(gallery)
                alert.addAction(cancel)

                self.present(alert, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        self.plantAddView.birthResetButton.rx.tap
            .bind { _ in
                self.viewModel.resetBirthDay()
                self.plantAddView.resetBirth()
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func handleDatePicker(_ sender: UIDatePicker) {
        let date = sender.date
        self.viewModel.birthDay.accept(date)
    }
    
    @objc func onClickSave(_ sender: UIButton) {
        
        if let name = self.viewModel.name.value {
            let plant = Plant(name: name)
            plant.birthAt = self.viewModel.birthDay.value
            
            if let image = self.plantAddView.imageView.image, let data = image.pngData() {
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                    do {
                        let fileName = "\(Int(Date.timeIntervalSinceReferenceDate)).png"
                        let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName)
                        try data.write(to: url, options: .atomic)
                        plant.fileName = fileName
                    } catch (let error) {
                        print("save error - \(error)")
                    }
                } else {
                    // @TODO: 권한 요청
                }
            }
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(plant)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension PlantAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            dismiss(animated: true) {
                self.plantAddView.imageView.image = image
            }
        }
    }
}
