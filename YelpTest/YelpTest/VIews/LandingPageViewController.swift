//
//  LandingPageViewController.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "BusinessCell"

class LandingPageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var businessArray : [Business]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getBusinessInfo()
    }
    
    
    
    func getBusinessInfo(){
        ProgressView.shared.showProgressView()
        LibraryAPI.sharedInstance.searchBusinessesBy(term: "food", Success: { (response) in
            ProgressView.shared.hideProgressView()
            self.businessArray = response.busisess
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
           
        }) { (error) in
            print(error)
            ProgressView.shared.hideProgressView()
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businessArray?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO: avoid force unwraping with guard let
        let currentBusiness = businessArray![indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BusinessCell
        cell.configure(with: currentBusiness)
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    
 

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        //let screenHeight = screenSize.height
        
        return CGSize(width: 150, height: 230)
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
