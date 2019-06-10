//
//  DetailTableViewController.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit
import MapKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var currentBussines:Business?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDetails()
    }
    
    func setupViewDetails(){
        guard let business = currentBussines  else {
            return
        }
        detailImage.downloaded(from: business.image)
        titleLabel.text = business.name
        ratingLabel.text = "Rating: \(business.rating) with: \(business.reviewCount) reviews"
        priceLabel.text = business.price
        Utility.setStatusLabel(label: statusLabel, isClosed: business.isClose)
        phoneLabel.text = business.displayPhone
        tableView.tableFooterView = UIView()
        Utility.setupMapView(mapview: mapView, locationData: business.coordinates)
    }
    
    


}
