//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    var ref : DocumentReference? = nil
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        navigationItem.title = "⚡️Flash Chat"
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        getDataFormFireStore()

    }
    
    func getDataFormFireStore(){
        db.collection("messages").order(by: "time").addSnapshotListener() { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.messages.append(Message(sender: document.data()["sender"] as! String, body: document.data()["message"] as! String))
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    if(!self.messages.isEmpty)
                    {
                        let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .none, animated: false)

                    }

                }
                print(self.messages.count)
            }
        
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
       ref = db.collection("messages").addDocument(data: [
        "sender": Auth.auth().currentUser?.email! ?? "",
            "message" : messageTextfield.text!,
            "time":Date()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
                
                DispatchQueue.main.async {
                    self.messageTextfield.text = ""
                }
            }
        }
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        }catch {
            print(error)
        }
    }
    
}


extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.labelTxt.text = messages[indexPath.row].body
        
        
        if(messages[indexPath.row].sender == Auth.auth().currentUser?.email)
        {
            cell.leftImgView.isHidden = true;
            cell.rightImgView.isHidden = false;
            cell.messageBubbleBG.backgroundColor = UIColor.blue
        }
        else{
            cell.rightImgView.isHidden = true;
            cell.leftImgView.isHidden = false;
            cell.messageBubbleBG.backgroundColor = UIColor.cyan

        }
        return cell;
    }
    
}
