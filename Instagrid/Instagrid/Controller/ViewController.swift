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
    
    
    // Button variable to allow picker controller to know which picture to activate
    var addButton1 = false
    var addButton2 = false
    var addButton3 = false
    var addButton4 = false
    var addButton5 = false
    var addButton6 = false
    
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
        addButton1 = true
        addPicture()
    }
    
    @IBAction func addPicture2Button(_ sender: Any) {
        addButton2 = true
        addPicture()
    }
    
    @IBAction func addPicture3Button(_ sender: Any) {
        addButton3 = true
        addPicture()
    }
    
    @IBAction func addPicture4Button(_ sender: Any) {
        addButton4 = true
        addPicture()
    }
    
    @IBAction func addPicture5Button(_ sender: Any) {
        addButton5 = true
        addPicture()
    }
    
    @IBAction func addPicture6Button(_ sender: Any) {
        addButton6 = true
        addPicture()
    }
    
    // Layout functions
    private func activateLayout(layoutselected: UIImageView!, buttonPictureA: UIButton!, buttonPictureB: UIButton!, buttonPictureC: UIButton!, buttonPictureD: UIButton!, pictureA: UIImageView!, pictureB: UIImageView!, pictureC: UIImageView!, pictureD: UIImageView!) {
        // Layout selector
        layout1selected.isHidden = true
        layout2selected.isHidden = true
        layout3selected.isHidden = true
        layoutselected.isHidden = false
        
        // Add pictures button
        buttonPicture1.isHidden = true
        buttonPicture2.isHidden = true
        buttonPicture3.isHidden = true
        buttonPicture4.isHidden = true
        buttonPicture5.isHidden = true
        buttonPicture6.isHidden = true
        buttonPictureA.isHidden = false
        buttonPictureB.isHidden = false
        buttonPictureC.isHidden = false
        buttonPictureD.isHidden = false
        
        // Show only pictures from this specific layout
        picture1.isHidden = true
        picture2.isHidden = true
        picture3.isHidden = true
        picture4.isHidden = true
        picture5.isHidden = true
        picture6.isHidden = true
        pictureA.isHidden = false
        pictureB.isHidden = false
        pictureC.isHidden = false
        pictureD.isHidden = false
    }
    
    // Methods to add the picture
    private func addPicture() {
        
        // Create an alert to give choice between camera and photo library
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this picture?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Get image from source type according method addPicture()
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = sourceType
            image.allowsEditing = true
            self.present(image, animated: true, completion: nil)
        }
    }
    
    //Attribute the picture to the correct UIImage
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Define which picture to show and to assign the image
            if addButton1 == true {
                picture1.isHidden = false
                picture1.image = image
            } else if addButton2 == true {
                picture2.isHidden = false
                picture2.image = image
            } else if addButton3 == true {
                picture3.isHidden = false
                picture3.image = image
            } else if addButton4 == true {
                picture4.isHidden = false
                picture4.image = image
            } else if addButton5 == true {
                picture5.isHidden = false
                picture5.image = image
            } else if addButton6 == true {
                picture6.isHidden = false
                picture6.image = image
            }
            
            // Re-initialize the button booleans
            addButton1 = false
            addButton2 = false
            addButton3 = false
            addButton4 = false
            addButton5 = false
            addButton6 = false
            
        } else {
            //To do: display error message
        }
        
        self.dismiss(animated: true, completion: nil)
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

