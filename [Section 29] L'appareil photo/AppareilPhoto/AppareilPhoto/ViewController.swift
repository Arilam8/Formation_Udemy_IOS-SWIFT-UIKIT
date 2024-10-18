//
//  ViewController.swift
//  AppareilPhoto
//
//  Created by Aristide LAMBERT on 16/10/2024.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var iv: UIImageView!
    
    var picker = UIImagePickerController()
    var libraryPicker: PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCamera()
        setupConfig()
    }
    
    func checkCamera() {
        let hasCam = UIImagePickerController.isSourceTypeAvailable(.camera)
        cameraBtn.isEnabled = hasCam
        if hasCam {
            setupPicker()
        }
    }
    
    
    @IBAction func takeAPIc(_ sender: UIButton) {
        switch sender.tag{
            case 0: self.present(picker, animated: true, completion: nil)
        case 1: self.present(libraryPicker!, animated: true, completion: nil)
            default: break
        }
            }
    

}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let r = results.first {
            let item = r.itemProvider
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self){ image, error in
                    DispatchQueue.main.async{
                        if let im = image as? UIImage{
                            self.iv.image = im
                        }
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setupConfig(){
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .automatic
        libraryPicker = PHPickerViewController(configuration: config)
        libraryPicker!.delegate = self
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func setupPicker(){
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            print("on a une image")
            self.iv.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
