//
//  SearchingBuyersViewController.swift
//  SwipeMe1
//
//  Created by Ashwin Vivek on 12/7/16.
//  Copyright © 2016 AshwinVivek. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchingBuyersViewController: UIViewController {
    @IBOutlet weak var searchingGraphic: UIActivityIndicatorView!
    
    var priceAgreed: String?
    var userID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchingGraphic.startAnimating()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
