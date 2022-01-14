//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var titleArray = "Chat App"

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "";
        
        
        var charInt = 0.0;
        
        for txt in titleArray {

            Timer.scheduledTimer(withTimeInterval: 0.1 * charInt, repeats: false, block: { timer in
                self.titleLabel.text?.append(txt)
            })
            
            charInt += 1;
        }
        
        

       
    }

}
