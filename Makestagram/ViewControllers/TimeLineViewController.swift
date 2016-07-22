//
//  TimeLineViewController.swift
//  Makestagram
//
//  Created by Irina Korneeva on 20/07/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse
class TimeLineViewController: UIViewController {
    var photoTakingHelper: PhotoTakingHelper?

    override func viewDidLoad() {
        super.viewDidLoad()

        // important
        self.tabBarController?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func takePhoto() {
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) {
            (image: UIImage?) in
            if let image = image {
                print("received a callback")
                let file = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(image, 1.0)!)!
                
                let objectPost = PFObject(className: "Post")
                objectPost["ImageFile"] = file
                objectPost.saveInBackground()
                
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
extension TimeLineViewController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
    
}