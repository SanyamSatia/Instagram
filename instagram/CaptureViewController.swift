//
//  CaptureViewController.swift
//  instagram
//
//  Created by Sanyam Satia on 3/3/17.
//  Copyright © 2017 Sanyam Satia. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(CaptureViewController.imageClicked(gesture:)))
        photoImageView.addGestureRecognizer(imageTapGesture)
        photoImageView.isUserInteractionEnabled = true
        
        captionTextView.layer.borderColor = UIColor.lightGray.cgColor
        captionTextView.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        photoImageView.image = editedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imageClicked(gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func onCamera(_ sender: Any) {
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.allowsEditing = true
        viewController.sourceType = .camera
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func onLibrary(_ sender: Any) {
        let viewController = UIImagePickerController()
        viewController.delegate = self
        viewController.allowsEditing = true
        viewController.sourceType = .savedPhotosAlbum
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Post.postUserImage(image: photoImageView.image, withCaption: captionTextView.text) { (success: Bool, error: Error?) in
            if success {
                print("posted photo")
                MBProgressHUD.hide(for: self.view, animated: true)
                self.tabBarController?.selectedIndex = 0
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
