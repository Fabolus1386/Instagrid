//
//  CollageImageViewController.swift
//  Instagrid
//
//  Created by Fabrice Ortega on 08/10/2020.
//

import UIKit

class CollageImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    // Plus button outlets
    @IBOutlet weak var buttonPicture1: UIButton!
    @IBOutlet weak var buttonPicture2: UIButton!
    @IBOutlet weak var buttonPicture3: UIButton!
    @IBOutlet weak var buttonPicture4: UIButton!
    @IBOutlet weak var buttonPicture5: UIButton!
    @IBOutlet weak var buttonPicture6: UIButton!
    
    // Pictures outlets
    @IBOutlet weak var picture1: UIImageView!
    @IBOutlet weak var picture2: UIImageView!
    @IBOutlet weak var picture3: UIImageView!
    @IBOutlet weak var picture4: UIImageView!
    @IBOutlet weak var picture5: UIImageView!
    @IBOutlet weak var picture6: UIImageView!
    
    
    // Used as parameter in the imagePickerView(), is equal to parameter from getImage method
    var picturePicker: UIImageView!
    
    // View to share outlet
    @IBOutlet weak var viewImageToShare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Add pictures button
    @IBAction func addPicture1Button(_ sender: Any) {
        getSource(pictureAddPicture: picture1)
    }
    
    @IBAction func addPicture2Button(_ sender: Any) {
        getSource(pictureAddPicture: picture2)
    }
    
    @IBAction func addPicture3Button(_ sender: Any) {
        getSource(pictureAddPicture: picture3)
    }
    
    @IBAction func addPicture4Button(_ sender: Any) {
        getSource(pictureAddPicture: picture4)
    }
    
    @IBAction func addPicture5Button(_ sender: Any) {
        getSource(pictureAddPicture: picture5)
    }
    
    @IBAction func addPicture6Button(_ sender: Any) {
        getSource(pictureAddPicture: picture6)
    }
    
    // Methods to show an alert to the user to choose between camera and library
    func getSource(pictureAddPicture: UIImageView!) {
        let alert = UIAlertController(title: "Image Selection", message: "Please select the source of the picture", preferredStyle: .actionSheet)
        // Camera button
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(pictureGetImage: pictureAddPicture, fromSourceType: .camera)
        }))
        // Photo library button
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(pictureGetImage: pictureAddPicture, fromSourceType: .photoLibrary)
        }))
        // Cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("addPicture")
    }
    
    //Get image , method is called in getSource method with source type as parameter
    func getImage(pictureGetImage: UIImageView!, fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = sourceType
            image.allowsEditing = true
            picturePicker = pictureGetImage
            self.present(image, animated: true, completion: nil)
            print("getImage")
        }
    }
    
    //Attribute the picture to the correct UIImage, is called when image is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            picturePicker.isHidden = false
            picturePicker.image = image
        } else {
            showAlert(title: "Error", message: "Instagrid could not access the camera nor the photo library")
        }
        
        self.dismiss(animated: true, completion: nil)
        print("imagePickerController")
    }
    
    // Method to show an alert (used if error occured when selecting a picture)
    func showAlert ( title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

}
