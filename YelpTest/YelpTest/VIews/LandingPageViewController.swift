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
    var selectedBusiness: Business?
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
        
        return indexPath.row % 3 == 0 ? CGSize(width: screenWidth - 40 , height: 230) :  CGSize(width: 150, height: 230)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let business = businessArray![indexPath.row]
        getDetailForBusiness(idBusiness: business.id)
    }
    
    func getDetailForBusiness(idBusiness:String){
        ProgressView.shared.showProgressView()
        LibraryAPI.sharedInstance.getDetailForBusinees(id: idBusiness, Success: { (response) in
            self.selectedBusiness = response
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToDetail", sender: response)
            }
        }) { (error) in
            debugPrint("Something wrong happen")
        }
          ProgressView.shared.hideProgressView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailTableViewController{
            destination.currentBussines =  self.selectedBusiness
        }
    }

}
