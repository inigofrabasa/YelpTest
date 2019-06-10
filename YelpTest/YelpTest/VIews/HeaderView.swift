//
//  HeaderView.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

protocol headerDelegate: class {
    func buttonClicked(_ value: String)
}



class HeaderView: UICollectionReusableView {
    
    weak var delegate: headerDelegate?
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let value = Utility.getValueForTag(tag:sender.tag)
        delegate?.buttonClicked(value)
    }
    
}
