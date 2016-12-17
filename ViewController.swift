//
//  ViewController.swift
//  SwipeMe1
//
//  Created by Ashwin Vivek on 12/5/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var VenmoID: UITextField!
    @IBOutlet weak var EmptyID: UILabel!
    
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var databaseHandle1: FIRDatabaseHandle?
    var arrayOfSellers = [String]()
    var arrayOfBuyers = [String]()
    var iWasAdded = false
    var userID = ""
    
    
    var countNumberOfBuyers = 0
    var countNumberOfSellers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = FIRDatabase.database().reference()
        
        EmptyID.isHidden = true
        
        databaseHandle = ref?.child("Users").child("Buyers").observe(.childAdded, with: { (snapshot) in
            
            let key = snapshot.key
            
            let buyer = snapshot.value as? NSDictionary
            if buyer != nil {
                if(self.iWasAdded == false){
                    arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.append(key)
                    self.countNumberOfBuyers += 1
                }
                self.iWasAdded = false
            }

        })
        
        databaseHandle1 = ref?.child("Users").child("Sellers").observe(.childAdded, with: { (snapshot) in
            
            let key = snapshot.key
            
            let seller = snapshot.value as? NSDictionary
            if seller != nil {
                if(self.iWasAdded == false){
                    arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.append(key)
                    self.countNumberOfSellers += 1
                }
                self.iWasAdded = false
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "BuyerSegue"){
            let DestViewController = segue.destination as! UINavigationController
            let BuyerData = DestViewController.topViewController as! BuyerViewController
             
                BuyerData.userID = userID
        }
        
        if (segue.identifier == "SellerSegue"){
            let DestViewController = segue.destination as! UINavigationController
            let SellerData = DestViewController.topViewController as! SellerViewController
                
                SellerData.userID = userID
        }
    }
    
    @IBAction func BuyerButton(_ sender: AnyObject) {
        
        if(VenmoID.text?.characters.count==0 && countNumberOfSellers == 0){
            EmptyID.text = "Please enter your Venmo ID"
            EmptyID.isHidden = false
            
        }
        else if(VenmoID.text?.characters.count == 0){
            EmptyID.text = "You forgot to enter your Venmo ID!"
            EmptyID.isHidden = false
        }
  
        else{
            EmptyID.isHidden = true
            userID = (ref?.child("Users").child("Buyers").childByAutoId().key)!
            let buyer = buyerObject(VenmoID: VenmoID.text!, Location: "")
            let buyerUpdates = ["/\(userID)" : buyer.getSnapshotValue()]
            ref?.child("Users").child("Buyers").updateChildValues(buyerUpdates)
            //ref?.child("Users").child("Buyers").child(userID).child("Venmo ID").setValue(VenmoID.text)
            arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.append(userID)
            countNumberOfBuyers+=1
            iWasAdded = true
            performSegue(withIdentifier: "BuyerSegue", sender: Any?.self)
        }
    }
    
    @IBAction func SellerButton(_ sender: AnyObject) {
        if(VenmoID.text?.characters.count == 0 && countNumberOfBuyers == 0){
            EmptyID.text = "Please enter your Venmo ID"
            EmptyID.isHidden = false
        }
        else if(VenmoID.text?.characters.count == 0){
            EmptyID.text = "You forgot to enter your Venmo ID!"
            EmptyID.isHidden = false
        }
    
        else{
            EmptyID.isHidden = true
            userID = (ref?.child("Users").child("Sellers").childByAutoId().key)!//child("Venmo ID").setValue(VenmoID.text)
            let seller = sellerObject(VenmoID: VenmoID.text!, Location: "")
            let sellerUpdates = ["/\(userID)" : seller.getSnapshotValue()]
            ref?.child("Users").child("Sellers").updateChildValues(sellerUpdates)
      
            arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.append(userID)
            
            countNumberOfSellers+=1
            iWasAdded = true
            performSegue(withIdentifier: "SellerSegue", sender: Any?.self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        VenmoID.resignFirstResponder()
        
    }

}

