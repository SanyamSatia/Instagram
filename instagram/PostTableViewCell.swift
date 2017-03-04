//
//  PostTableViewCell.swift
//  instagram
//
//  Created by Sanyam Satia on 3/4/17.
//  Copyright © 2017 Sanyam Satia. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: Post! {
        didSet {
            usernameLabel.text = post.username
            
            if let file = post.file {
                file.getDataInBackground(block: { (data: Data?, error: Error?) in
                    self.photoImageView.image = UIImage(data: data!)
                })
            }
            
            captionLabel.text = post.caption
            
            if let timestamp = post.timestamp {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM dd HH:mm"
                timestampLabel.text = formatter.string(from: timestamp)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
