//
//  Post.swift
//  Makestagram
//
//  Created by Irina Korneeva on 24/07/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

// 1
class Post : PFObject, PFSubclassing {
    
    // 2
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    //MARK: PFSubclassing Protocol
    var image: UIImage?
    // 3
    static func parseClassName() -> String {
        return "Post"
    }
    override init () {
        super.init()
    }
    
   /* override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }*/
    
    func uploadPost() {
       
        
        if let image = image {
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
             let imageData = UIImageJPEGRepresentation(image, 1.0)!
            guard let imageFile = PFFile(name: "image.jpg", data: imageData) else {return}
            
            // any uploaded post should be associated with the current user
            user = PFUser.currentUser()
            self.imageFile = imageFile
            
            // 1
            
            
            // 2
            saveInBackgroundWithBlock()
            { (success: Bool, error: NSError?) in
                // 3
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
        }
    }
    // 4
    
    
}