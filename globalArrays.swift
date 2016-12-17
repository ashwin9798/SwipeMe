//
//  diningHallsArray.swift
//  SwipeMe1
//
//  Created by Ashwin Vivek on 12/6/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import Foundation


class diningHallArrays {
    
    // These are the properties you can store in your singleton
    var BPlate = [String]()
    var Cafe1919 = [String]()
    var Covel = [String]()
    var DeNeve = [String]()
    var Feast = [String]()
    var Rendezvous = [String]()

    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: diningHallArrays {
        struct Static {
            static let instance = diningHallArrays()
        }
        return Static.instance
    }
}

class arrayOfBuyersAndSellers {
    
    var arrayOfBuyers = [String]()
    var arrayOfSellers = [String]()
    
    class var sharedManager: arrayOfBuyersAndSellers {
        struct Static {
            static let instance = arrayOfBuyersAndSellers()
        }
        return Static.instance
    }
    
}



