//
//  BusinessCell.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

class BusinessCell: UICollectionViewCell {
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var statusIndicator: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    public func configure(with model: Business) {
        businessImage.downloaded(from: model.image)
        nameLabel.text = model.name
        ratingLabel.text = "Rating: " + String(model.rating)
        priceLabel.text = "Price: " + model.price
        phoneLabel.text = "Phone:" + model.phone
        setStatusinCell(with: model)
        self.layer.cornerRadius = self.frame.width / 20
        self.layer.masksToBounds = true
    }
    
    func setStatusinCell (with model: Business) {
        statusIndicator.layer.cornerRadius = statusIndicator.frame.width / 2
        statusIndicator.layer.masksToBounds = true
        let color  = model.isClose ? UIColor.red : UIColor.green
        statusIndicator.backgroundColor = color
    }
    
    override func prepareForReuse() {
        businessImage.image = nil
        nameLabel.text = ""
        ratingLabel.text = ""
        priceLabel.text = ""
        phoneLabel.text = ""
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
