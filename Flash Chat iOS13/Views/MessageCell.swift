//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Mohamed Nasr on 15/11/2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var labelTxt: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var rightImgView: UIImageView!
    @IBOutlet weak var leftImgView: UIImageView!
    @IBOutlet weak var messageBubbleBG: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = 6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
