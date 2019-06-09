//
//  DemoViewController.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func click(_ sender: Any) {
         self.callService()
    }
    
    func callService (){
       ProgressView.shared.showProgressView()
        LibraryAPI.sharedInstance.searchBusinessesBy(term: "food", Success: { (response) in
            print(response)
             ProgressView.shared.hideProgressView()
        }) { (error) in
            print(error)
            ProgressView.shared.hideProgressView()
        }
    }


}
