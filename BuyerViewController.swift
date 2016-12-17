//
//  BuyerViewController.swift
//  SwipeMe1
//
//  Created by Ashwin Vivek on 12/5/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BuyerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var CollectionViewOfSellers: UICollectionView!

    var userID: String = ""
    var LocationString: String?
    
    var ref:FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var databaseHandle1: FIRDatabaseHandle?
    
    let hallArray = ["B-Plate", "Café 1919", "Covel", "De Neve", "Feast", "Rendezvous"]
    let namesOfMembers = ["DeNeve", "Covel", "BPlate", "Feast", "Rendezvous", "Cafe1919"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CollectionViewOfSellers.backgroundColor = UIColor.clear
        
        ref = FIRDatabase.database().reference()
        
        CollectionViewOfSellers.delegate = self
        CollectionViewOfSellers.dataSource = self
        
        self.ref?.child("Users").child("Sellers").observe(.childChanged, with: {(snapshot) in
            
            
            let buyer = snapshot.value as? NSDictionary
            
            self.LocationString = buyer?["Location"] as! String?
            
            if self.LocationString != nil{
                
//                self.CollectionViewOfSellers.reloadItems(at: self.CollectionViewOfSellers.indexPathsForVisibleItems)
                
                // GCD
                OperationQueue.main.addOperation(self.CollectionViewOfSellers.reloadData)
                
                // Dispatch Queue
                DispatchQueue.main.async(execute: self.CollectionViewOfSellers.reloadData)
                
                
            }
            
        })
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewOfSellers.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath) as! ViewControllerCollectionViewCell
        
        cell.diningHallNameLabel?.text = self.hallArray[indexPath.row]
        
        
        switch(indexPath.row){
        case 0:
            cell.numberSellingLabel?.text = "\((diningHallArrays.sharedManager.BPlate).count) people selling";
            print((diningHallArrays.sharedManager.BPlate).count)
            break
        case 1:
            cell.numberSellingLabel?.text = "\((diningHallArrays.sharedManager.Cafe1919).count) people selling";
            print((diningHallArrays.sharedManager.Cafe1919).count)
            break
        case 2:
            cell.numberSellingLabel?.text = "\((diningHallArrays.sharedManager.Covel).count) people selling";
            print((diningHallArrays.sharedManager.Covel).count)
            break
        case 3:
            cell.numberSellingLabel?.text = "\((diningHallArrays.sharedManager.DeNeve).count) people selling";
            print((diningHallArrays.sharedManager.DeNeve).count)
            break
        case 4:
            cell.numberSellingLabel?.text = "\((diningHallArrays.sharedManager.Feast).count) people selling";
            print((diningHallArrays.sharedManager.Feast).count)
            break
        case 5:
            cell.numberSellingLabel?.text = "\((diningHallArrays.sharedManager.Rendezvous).count) people selling";
            print((diningHallArrays.sharedManager.Rendezvous).count)
            break
        default:
            break
        }
        return cell

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
