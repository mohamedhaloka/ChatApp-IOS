//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {  authResult, error in
          if error == nil
            {
              self.performSegue(withIdentifier: K.loginSegue, sender: self);
          }else
          {
              self.hintLabel.text = error?.localizedDescription
          }
        }
        
    }
    
}
