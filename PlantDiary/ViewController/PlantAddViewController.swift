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

    lazy var plantAddView: PlantAddView = {
        let plantAddView = PlantAddView(frame: self.view.frame)
        return plantAddView
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        return button
    }()
    
    var name = BehaviorRelay<String>(value: "")
    var birthDay = BehaviorRelay<Date?>(value: nil)
    var imageUrl = BehaviorRelay<String>(value: "")
    
    let disposeBag = DisposeBag()
    
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
    }
    
    func rxBind() {
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

extension PlantAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            dismiss(animated: true) {
                self.plantAddView.imageView.image = image
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                let imageUrl = documentsPath + "/" + "\(Date.timeIntervalSinceReferenceDate)"
                self.imageUrl.accept(imageUrl)
            }
        }
    }
}
