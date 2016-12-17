//
//  SellerViewController.swift
//  SwipeMe1
//
//  Created by Ashwin Vivek on 12/5/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SellerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var MarketPriceLabel: UILabel!
    @IBOutlet weak var backButtonForSeller: UINavigationItem!
    
    @IBOutlet weak var Heading: UILabel!
    @IBOutlet weak var SelectedHallLabel: UILabel!
    
    @IBOutlet weak var PickerView: UIPickerView!
    
    var diningHalls = ["B-Plate", "Café 1919", "Covel", "De Neve", "FEAST", "Rendezvous"]
    var whichDiningHallSelected = 0

    var userID: String = ""

    
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var databaseHandle1: FIRDatabaseHandle?
    
    var PriceOfSwipe: String = ""
    var BuyerAlreadyThere: Bool = false
    var SellerAlreadyThere: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = FIRDatabase.database().reference()
        
        PickerView.delegate = self
        PickerView.dataSource = self
        SelectedHallLabel.isHidden = true
        
        self.PriceOfSwipe = self.MarketPrice(ratio: Double((Double(arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.count))/(Double(arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.count))))
        self.Heading.isHidden = false
        self.MarketPriceLabel.text = "$\(self.PriceOfSwipe)"
        
        databaseHandle = ref?.child("Users").child("Buyers").observe(.childAdded, with: { (snapshot) in
            
            let key = snapshot.key
            
            let buyer = snapshot.value as? NSDictionary
            if buyer != nil {
                for index in 0...arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.count-1{
                    if(key == arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers[index]){
                        self.BuyerAlreadyThere = true
                        break
                    }
                }
                if(key != self.userID && !self.BuyerAlreadyThere){
                    arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.append(key)
                }
                self.PriceOfSwipe = self.MarketPrice(ratio: Double((Double(arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.count))/(Double(arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.count))))
                self.Heading.isHidden = false
                self.MarketPriceLabel.text = "$\(self.PriceOfSwipe)"
            }
            self.BuyerAlreadyThere = false
        })
        
        databaseHandle1 = ref?.child("Users").child("Sellers").observe(.childAdded, with: { (snapshot) in
            
            let key = snapshot.key
            
            let seller = snapshot.value as? NSDictionary
            if seller != nil {
                
                for index in 0...arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.count-1{
                    if(key == arrayOfBuyersAndSellers.sharedManager.arrayOfSellers[index]){
                        self.SellerAlreadyThere = true
                        break
                    }
                }

                if(key != self.userID && !self.SellerAlreadyThere){
                    arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.append(key)
                }
                if(arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.count == 0){
                    self.MarketPriceLabel.adjustsFontSizeToFitWidth = true
                    self.Heading.isHidden = true
                    self.MarketPriceLabel.text = "No Buyers Found"
                }
                else{
                    self.PriceOfSwipe = self.MarketPrice(ratio: Double((Double(arrayOfBuyersAndSellers.sharedManager.arrayOfBuyers.count))/(Double(arrayOfBuyersAndSellers.sharedManager.arrayOfSellers.count))))
                    self.Heading.isHidden = false
                    self.MarketPriceLabel.text = "$\(self.PriceOfSwipe)"
                }
            }
            self.SellerAlreadyThere = false
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return diningHalls[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return diningHalls.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        whichDiningHallSelected = row
        SelectedHallLabel.isHidden = false
        SelectedHallLabel.text = diningHalls[row]
    }
    
    func MarketPrice(ratio: Double) -> String{
        
        var price:Double
        
        if (ratio == 0){
            price = 5.00;
        }
        
        else if (0 < ratio && ratio <= 0.1){
            price = 4.5 + 4*(0.1166666666667);
        }
        
        else if (0.1 < ratio && ratio <= 0.2){
            price = 4.5 + 4*(0.1666666666667);
        }
        
        else if (0.2 < ratio && ratio <= 0.3){
            price = 4.5 + 4*(0.2333333333333);
        }
        
        else if (0.3 < ratio && ratio <= 0.4){
            price = 4.5 + 4*(0.2833333333333);
        }
        
        else if (0.4 < ratio && ratio <= 0.5){
            price = 4.5 + 4*(0.35);
        }
        
        else if (0.5 < ratio && ratio <= 0.6){
            price = 4.5 + 4*(0.4);
        }
        
        else if (0.6 < ratio && ratio <= 0.7){
            price = 4.5 + 4*(0.433333333333);
        }
        
        else if (0.7 < ratio && ratio <= 0.8){
            price = 4.5 + 4*(0.45);
        }
        
        else if (0.8 < ratio && ratio <= 0.9){
            price = 4.5 + 4*(0.4833333333333);
        }
        
        else if (0.9 < ratio && ratio <= 1){
            price = 4.5 + 4*(0.5);
        }
        
        else if (1 < ratio && ratio <= 1.1){
            price = 4.5 + 4*(0.5);
        }
        
        else if (1.1 < ratio && ratio <= 1.2){
            price = 4.5 + 4*(0.58);
        }
        
        else if (1.2 < ratio && ratio <= 1.3){
            price = 4.5 + 4*(0.65);
        }
        
        else if (1.3 < ratio && ratio <= 1.4){
            price = 4.5 + 4*(0.71666666666667);
        }
        
        else if (1.4 < ratio && ratio <= 1.5){
            price = 4.5 + 4*(0.816666666666667);
        }
        
        else if (1.5 < ratio && ratio <= 1.6){
            price = 4.5 + 4*(0.9333333333333);
        }
            
        else {
            price = 9
        }
        
        let roundedPrice = String(format: "%.2f", price)
        
        return roundedPrice;
    }
    
    @IBAction func ChoseDiningHallButton(_ sender: AnyObject) {
        
        switch(whichDiningHallSelected){
            case 0:
                self.ref?.child("Users").child("Sellers").child(userID).child("Location").setValue("B-Plate");
                diningHallArrays.sharedManager.BPlate.append(userID);
                print(diningHallArrays.sharedManager.BPlate.count);
                    break
            case 1:
                self.ref?.child("Users").child("Sellers").child(userID).child("Location").setValue("Cafe 1919");
                diningHallArrays.sharedManager.Cafe1919.append(userID);
                    break
            case 2:
            self.ref?.child("Users").child("Sellers").child(userID).child("Location").setValue("Covel");
            diningHallArrays.sharedManager.Covel.append(userID);
                    break
            case 3:
                self.ref?.child("Users").child("Sellers").child(userID).child("Location").setValue("De Neve");
                diningHallArrays.sharedManager.DeNeve.append(userID);
                    break
            case 4:
                self.ref?.child("Users").child("Sellers").child(userID).child("Location").setValue("Feast");
                diningHallArrays.sharedManager.Feast.append(userID);
                    break
            case 5:
                self.ref?.child("Users").child("Sellers").child(userID).child("Location").setValue("Rendezvous");
                diningHallArrays.sharedManager.Rendezvous.append(userID);
                    break
            default:
                    break
            
        }
        performSegue(withIdentifier: "searchingBuyersSegue", sender: Any?.self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "searchingBuyersSegue"){
            let DestViewController = segue.destination as! UINavigationController
            let SellerViewControllerData = DestViewController.topViewController as! SearchingBuyersViewController
            
            SellerViewControllerData.priceAgreed = MarketPriceLabel?.text
            SellerViewControllerData.userID = userID
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
