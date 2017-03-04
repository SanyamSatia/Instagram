//
//  Post.swift
//  instagram
//
//  Created by Sanyam Satia on 3/3/17.
//  Copyright © 2017 Sanyam Satia. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {

    var username: String?
    var file: PFFile?
    var caption: String?
    var timestamp: Date?
    
    init(object: PFObject) {
        let user = object["author"] as! PFUser?
        username = user?.username
        
        file = object["media"] as! PFFile?
        caption = object["caption"] as! String?
        timestamp = object["createdAt"] as! Date?
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = PFObject(className: "Post")

        post["media"] = Post.getPFFileFromImage(image: image)
        post["author"] = PFUser.current()
        post["caption"] = caption
        post["createdAt"] = Date()
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        post.saveInBackground { (success: Bool, error: Error?) in
            if success {
                if let completion = completion {
                    completion(true, nil)
                }
            }
            else {
                if let completion = completion {
                    completion(false, error)
                }
            }
        }
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func postsFromArray(objects: [PFObject]) -> [Post] {
        var posts: [Post] = []
        
        for object in objects {
            let post = Post(object: object)
            posts.append(post)
        }
        
        return posts
    }
}
