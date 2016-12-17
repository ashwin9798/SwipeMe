//
//  user.swift
//  SwipeMe1
//
//  Created by Ashwin Vivek on 12/6/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import Firebase

class buyerObject{
    
    let VenmoID: String
    let Location: String
    
    let kID = "VenmoID"
    let kLocation = ""

    
    init (VenmoID: String, Location:String) //lat: String, long: String)
    {
        self.VenmoID = VenmoID
        self.Location = kLocation
    }
    
    init(snapshotValue: FIRDataSnapshot)
    {
        self.VenmoID = (snapshotValue.value as! NSDictionary)[self.kID] as! String
        self.Location = (snapshotValue.value as! NSDictionary)[self.kLocation] as! String
        //self.lat = (snapshot.value as! NSDictionary)[self.klat] as! String
        //self.long = (snapshot.value as! NSDictionary)[self.klong] as! String
    }
    
    func getSnapshotValue() -> NSDictionary {
        return ["VenmoID": VenmoID, "Location": Location] //, "lat": lat, "long": long]//"key": key, "location": location,
    }
}

class sellerObject{
    
    let VenmoID: String
    let Location: String
    
    let kID = "VenmoID"
    let kLocation = ""
    
    
    init (VenmoID: String, Location:String) //lat: String, long: String)
    {
        self.VenmoID = VenmoID
        self.Location = kLocation
        
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        self.VenmoID = (snapshot.value as! NSDictionary)[self.kID] as! String
        self.Location = (snapshot.value as! NSDictionary)[self.kLocation] as! String
        //self.lat = (snapshot.value as! NSDictionary)[self.klat] as! String
        //self.long = (snapshot.value as! NSDictionary)[self.klong] as! String
    }
    
    func getSnapshotValue() -> NSDictionary {
        return ["VenmoID": VenmoID, "Location": Location] //, "lat": lat, "long": long]//"key": key, "location": location,
    }
    
}
