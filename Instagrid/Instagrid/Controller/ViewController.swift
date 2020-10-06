//
//  ViewController.swift
//  Instagrid
//
//  Created by Fabrice Ortega on 24/09/2020.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Layout selection outlets
    @IBOutlet weak var layout1selected: UIImageView!
    @IBOutlet weak var layout2selected: UIImageView!
    @IBOutlet weak var layout3selected: UIImageView!
    
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
    
    // View to share outlet
    @IBOutlet weak var viewImageToShare: UIView!
    
    // Swipe label
    @IBOutlet weak var swipeLabel: UILabel!
    
    // Used as parameter in the imagePickerView(), is equal to parameter from getImage method
    var picturePicker: UIImageView!
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Add swipe gesture recognition
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

    }
    
    // Layout buttons
    @IBAction func layoutButton1(_ sender: Any) {
        // buttonPictureD & pictureD are used as duplicated as this layout contains 3 pictures
        activateLayout(layoutselected: layout1selected, buttonPictureA: buttonPicture3, buttonPictureB: buttonPicture4, buttonPictureC: buttonPicture5, buttonPictureD: buttonPicture5, pictureA: picture3, pictureB: picture4, pictureC: picture5, pictureD: picture5)
    }
    
    @IBAction func layoutButton2(_ sender: Any) {
        // buttonPictureD & pictureD are used as duplicated as this layout contains 3 pictures
        activateLayout(layoutselected: layout2selected, buttonPictureA: buttonPicture1, buttonPictureB: buttonPicture2, buttonPictureC: buttonPicture6, buttonPictureD: buttonPicture6, pictureA: picture1, pictureB: picture2, pictureC: picture6, pictureD: picture6)
    }
    
    @IBAction func layoutButton3(_ sender: Any) {
        activateLayout(layoutselected: layout3selected, buttonPictureA: buttonPicture1, buttonPictureB: buttonPicture2, buttonPictureC: buttonPicture3, buttonPictureD: buttonPicture4, pictureA: picture1, pictureB: picture2, pictureC: picture3, pictureD: picture4)
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
    
    // Layout functions
    private func activateLayout(layoutselected: UIImageView!, buttonPictureA: UIButton!, buttonPictureB: UIButton!, buttonPictureC: UIButton!, buttonPictureD: UIButton!, pictureA: UIImageView!, pictureB: UIImageView!, pictureC: UIImageView!, pictureD: UIImageView!) {
        // Layout selector
        hideLayoutSelector()
        layoutselected.isHidden = false
        
        // Add pictures button
        hidePictureButton()
        buttonPictureA.isHidden = false
        buttonPictureB.isHidden = false
        buttonPictureC.isHidden = false
        buttonPictureD.isHidden = false
        
        // Show only pictures from this specific layout
        hideAllPictures()
        pictureA.isHidden = false
        pictureB.isHidden = false
        pictureC.isHidden = false
        pictureD.isHidden = false
    }
    
    // Methods to show an alert to the user to choose between camera and library
    private func getSource(pictureAddPicture: UIImageView!) {
        
        // Create an alert to give choice between camera and photo library
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this picture?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(pictureGetImage: pictureAddPicture, fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(pictureGetImage: pictureAddPicture, fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("addPicture")
    }
    
    //Get image from source type according method addPicture()
    private func getImage(pictureGetImage: UIImageView!, fromSourceType sourceType: UIImagePickerController.SourceType) {
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
    
    //Attribute the picture to the correct UIImage
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
    
    // Swipe method
    @objc func swipe(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left && UIDevice.current.orientation.isLandscape == true {
            print("Swipe Left")
            share()
        }
        else if gesture.direction == .up && UIDevice.current.orientation.isPortrait == true {
            print("Swipe Up")
            share()
        }
    }
    
    // Share method
    func share() {
        let size = self.viewImageToShare.frame.size
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        viewImageToShare.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Share
        let activityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // Method to show an alert (used if error occured when selecting a picture)
    private func showAlert ( title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Method to hide all layout selectors
    private func hideLayoutSelector() {
        layout1selected.isHidden = true
        layout2selected.isHidden = true
        layout3selected.isHidden = true
    }
    
    // Method to hide all picture buttons
    private func hidePictureButton() {
        buttonPicture1.isHidden = true
        buttonPicture2.isHidden = true
        buttonPicture3.isHidden = true
        buttonPicture4.isHidden = true
        buttonPicture5.isHidden = true
        buttonPicture6.isHidden = true
    }
    
    // Method to hide all picture
    private func hideAllPictures() {
        picture1.isHidden = true
        picture2.isHidden = true
        picture3.isHidden = true
        picture4.isHidden = true
        picture5.isHidden = true
        picture6.isHidden = true
    }
    
    // Change swip label according phone orientation
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        if (toInterfaceOrientation.isPortrait) {
            print("Portrait")
            swipeLabel.text = "Swipe up to share"
        }
        else {
            print("landscape")
            swipeLabel.text = "Swipe left to share"
        }
    }
}

