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
    
    // Parameters to be equal to the outlets in CollageImageViewController
    var buttonPicture1: UIButton!
    var buttonPicture2: UIButton!
    var buttonPicture3: UIButton!
    var buttonPicture4: UIButton!
    var buttonPicture5: UIButton!
    var buttonPicture6: UIButton!
    var picture1: UIImageView!
    var picture2: UIImageView!
    var picture3: UIImageView!
    var picture4: UIImageView!
    var picture5: UIImageView!
    var picture6: UIImageView!
    var viewImageToShare: UIView!
    
    // Parameter for to show the path to the CollageImageViewController
    var vc2: CollageImageViewController!
    
    // Swipe label
    @IBOutlet weak var swipeLabel: UILabel!
    
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
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCollageImage" {
            DispatchQueue.main.async{
                self.vc2 = segue.destination as? CollageImageViewController
                self.attributeParamatersForSegue()
            }
        }
    }
    
    // Method to call the viewDidLoad of the CollageImageViewController
    func callviewDidLoadOfCollageImageViewController() {
        self.vc2.viewDidLoad()
    }
    
    
    // Layout buttons
    @IBAction func layoutButton1(_ sender: Any) {
        callviewDidLoadOfCollageImageViewController()
        
        // buttonPictureD & pictureD are used as duplicated as this layout contains 3 pictures
        activateLayout(layoutselected: layout1selected,
                       buttonPictureA: buttonPicture3,
                       buttonPictureB: buttonPicture4,
                       buttonPictureC: buttonPicture5,
                       buttonPictureD: buttonPicture5,
                       pictureA: picture3,
                       pictureB: picture4,
                       pictureC: picture5,
                       pictureD: picture5)
    }
    
    @IBAction func layoutButton2(_ sender: Any) {
        callviewDidLoadOfCollageImageViewController()
        
        // buttonPictureD & pictureD are used as duplicated as this layout contains 3 pictures
        activateLayout(layoutselected: layout2selected,
                       buttonPictureA: buttonPicture1,
                       buttonPictureB: buttonPicture2,
                       buttonPictureC: buttonPicture6,
                       buttonPictureD: buttonPicture6,
                       pictureA: picture1,
                       pictureB: picture2,
                       pictureC: picture6,
                       pictureD: picture6)
    }
    
    @IBAction func layoutButton3(_ sender: Any) {
        callviewDidLoadOfCollageImageViewController()
        
        activateLayout(layoutselected: layout3selected,
                       buttonPictureA: buttonPicture1,
                       buttonPictureB: buttonPicture2,
                       buttonPictureC: buttonPicture3,
                       buttonPictureD: buttonPicture4,
                       pictureA: picture1,
                       pictureB: picture2,
                       pictureC: picture3,
                       pictureD: picture4)
    }
    
    
    // Layout functions
    func activateLayout(layoutselected: UIImageView!,
                        buttonPictureA: UIButton!,
                        buttonPictureB: UIButton!,
                        buttonPictureC: UIButton!,
                        buttonPictureD: UIButton!,
                        pictureA: UIImageView!,
                        pictureB: UIImageView!,
                        pictureC: UIImageView!,
                        pictureD: UIImageView!) {
        // Layout selector
        hideLayoutSelector()
        layoutselected.isHidden = false
        
        // Add pictures button
        activateButtons(buttonPictureOne: buttonPictureA,
                        buttonPictureTwo: buttonPictureB,
                        buttonPictureThree: buttonPictureC,
                        buttonPictureFour: buttonPictureD)
        
        // Show only pictures from this specific layout
        activatePictures(pictureOne: pictureA,
                         pictureTwo: pictureB,
                         pictureThree: pictureC,
                         pictureFour: pictureD)
    }
    
    // Hide all + buttons except the four ones in parameters
    func activateButtons(buttonPictureOne: UIButton!,
                         buttonPictureTwo: UIButton!,
                         buttonPictureThree: UIButton!,
                         buttonPictureFour: UIButton!) {
        hidePictureButton()
        buttonPictureOne.isHidden = false
        buttonPictureTwo.isHidden = false
        buttonPictureThree.isHidden = false
        buttonPictureFour.isHidden = false
    }
    
    // Hide all images except the four ones in parameters
    func activatePictures(pictureOne: UIImageView!,
                          pictureTwo: UIImageView!,
                          pictureThree: UIImageView!,
                          pictureFour: UIImageView!) {
        hideAllPictures()
        pictureOne.isHidden = false
        pictureTwo.isHidden = false
        pictureThree.isHidden = false
        pictureFour.isHidden = false
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
    
    // Share method and create picture
    func share() {
        callviewDidLoadOfCollageImageViewController()
        
        // Create collage picture
        let size = viewImageToShare.frame.size
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        viewImageToShare.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Share
        let activityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // Method to hide all layout selectors
    func hideLayoutSelector() {
        layout1selected.isHidden = true
        layout2selected.isHidden = true
        layout3selected.isHidden = true
    }
    
    // Method to hide all picture buttons
    func hidePictureButton() {
        callviewDidLoadOfCollageImageViewController()
        
        buttonPicture1.isHidden = true
        buttonPicture2.isHidden = true
        buttonPicture3.isHidden = true
        buttonPicture4.isHidden = true
        buttonPicture5.isHidden = true
        buttonPicture6.isHidden = true
    }
    
    // Method to hide all picture
    func hideAllPictures() {
        callviewDidLoadOfCollageImageViewController()
        
        picture1.isHidden = true
        picture2.isHidden = true
        picture3.isHidden = true
        picture4.isHidden = true
        picture5.isHidden = true
        picture6.isHidden = true
    }
    
    // Method to attribute the parameters of ViewController to the parameters of CollageImageViewController thru the segue
    func attributeParamatersForSegue(){
        self.buttonPicture1 = self.vc2.buttonPicture1
        self.buttonPicture2 = self.vc2.buttonPicture2
        self.buttonPicture3 = self.vc2.buttonPicture3
        self.buttonPicture4 = self.vc2.buttonPicture4
        self.buttonPicture5 = self.vc2.buttonPicture5
        self.buttonPicture6 = self.vc2.buttonPicture6
        self.picture1 = self.vc2.picture1
        self.picture2 = self.vc2.picture2
        self.picture3 = self.vc2.picture3
        self.picture4 = self.vc2.picture4
        self.picture5 = self.vc2.picture5
        self.picture6 = self.vc2.picture6
        self.viewImageToShare = self.vc2.viewImageToShare
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

