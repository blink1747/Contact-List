//
//  ImageViewController.swift
//  Contact List
//
//  Created by IMCS on 8/13/19.
//  Copyright © 2019 IMCS. All rights reserved.
//

import UIKit


class ImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var receiveContact = ContactStruct(givenName: "", familyName: "", number: "")
    
    @IBOutlet weak var ContactName: UILabel!
    
    
    @IBAction func standardAlert(_ sender: Any) {
    
        let alertController = UIAlertController(title: "Hey There", message:  "Are you sure?",
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: {(action) in
            print("Yes tapped")
        }))
        
        alertController.addAction(UIAlertAction(title: "Not Now", style: UIAlertAction.Style.destructive, handler: { (action) in
            print("Yes tapped")
        }))
        
        alertController.addAction(UIAlertAction(title: "Not Now", style: UIAlertAction.Style.cancel, handler: { (action) in
            print("Not Now tapped")
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func actionSheetAlert(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Import from Photo Library", style: UIAlertAction.Style.default,
                                                handler: { (action) in
                                                    
          
            imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
            imageController.allowsEditing = false
            self.present(imageController, animated: true, completion: nil)

                                                    
        }))
        
        alertController.addAction(UIAlertAction(title: "Import from Camera", style: UIAlertAction.Style.default,
                                                handler: { (action) in
                                                    
                                                    imageController.sourceType = UIImagePickerController.SourceType.camera
                                                    imageController.allowsEditing = false
                                                    self.present(imageController, animated: true, completion: nil)

                                                    
        }))
        
        alertController.addAction(UIAlertAction(title: "Not Now", style: UIAlertAction.Style.cancel, handler: {(action) in print("Not Now tapped")}))
        
        self.present(alertController, animated: true, completion: nil)
        
}
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = pickedImage
        } else {
                print("Error Picking Image")
            }
            self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    @IBAction func importImageAction(_ sender: Any) {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imageController.allowsEditing = false
        self.present(imageController, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactName.text = receiveContact.givenName + " " + receiveContact.familyName 
        
        // Do any additional setup after loading the view.
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
