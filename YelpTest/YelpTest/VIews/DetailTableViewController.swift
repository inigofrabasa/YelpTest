//
//  DetailTableViewController.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var currentBussines:Business?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDetails()
    }
    
    func setupViewDetails(){
        guard let bussines = currentBussines  else {
            return
        }
        detailImage.downloaded(from: bussines.image)
        titleLabel.text = bussines.name
    }


}
