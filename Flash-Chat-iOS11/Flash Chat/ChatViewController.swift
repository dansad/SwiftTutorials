//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    var messages : [Message] = [Message]()
    

    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        
        messageTableView.separatorStyle = .none
        //TODO: Set yourself as the delegate and datasource here:
        
        
        
        //TODO: Set yourself as the delegate of the text field here:

        
        
        //TODO: Set the tapGesture here:
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tableviewTapped))
        messageTableView.addGestureRecognizer(tap)
        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        
        retreiveMessages()
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        let messageArray = self.messages
        
        if messageArray.count > 0{
          cell.messageBody.text = messageArray[indexPath.row].messageBody
          cell.senderUsername.text = messageArray[indexPath.row].sender
            cell.avatarImageView.image = UIImage(named: "egg")
            let isSelf : Bool = (cell.senderUsername.text == Auth.auth().currentUser!.email)
            if isSelf{
                cell.avatarImageView.backgroundColor = UIColor.flatMint()
                cell.messageBackground.backgroundColor = UIColor.flatMint()
            }
            else{
                cell.avatarImageView.backgroundColor = UIColor.flatSkyBlue()
                cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
            }
        
        }
        return cell
    }
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    
    //TODO: Declare tableViewTapped here:
    @objc func tableviewTapped(){
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTableView(){
        messageTableView.estimatedRowHeight = 120.0
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.reloadData()
    }
    
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
       
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5){
        self.heightConstraint.constant = 50
        self.view.layoutIfNeeded()
        }
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        //TODO: Send the message to Firebase and save it in our database
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDict = ["Sender": Auth.auth().currentUser?.email, "Message":messageTextfield.text!]
        messagesDB.childByAutoId().setValue(messageDict){
            (error, reference) in
            if error != nil{
                print("Errorrrr!!! \(error!.localizedDescription)")
            }
            else{
                print ("OK: \(reference.description())")
            }
            self.messageTextfield.isEnabled = true
            self.messageTextfield.text = ""
            self.sendButton.isEnabled = true
        }
        
    }
    
    //TODO: Create the retrieveMessages method here:
    func retreiveMessages(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["Message"]!
            let sender = snapshotValue["Sender"]!
            let newMessage = Message()
            newMessage.messageBody = text
            newMessage.sender = sender
            self.messages.append(newMessage)
            self.configureTableView()
        }
    }
    
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut();
            navigationController?.popToRootViewController(animated: true)
        }
        catch{
            print("Error. Signout bad: \(error.localizedDescription)");
        }
        
        
        
        
    }
    


}
