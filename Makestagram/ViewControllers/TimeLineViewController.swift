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
    
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    
    var photoTakingHelper: PhotoTakingHelper?

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ParseHelper.timelineRequestForCurrentUser {
            (result: [PFObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
        self.tabBarController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
            let post = Post()
            post.image.value = image
            post.uploadPost()
        }
    }

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

extension TimeLineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let post = posts[indexPath.row]
        // 1
        post.downloadImage()
        
        post.fetchLikes()
        // 2
        cell.post = post
        
        return cell
    }
}