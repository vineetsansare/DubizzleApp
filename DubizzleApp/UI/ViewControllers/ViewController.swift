//
//  ViewController.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/19/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class ViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var productListCollectionView: UICollectionView!
    var productList: Array<ProductModel>?
    var filteredProductList: Array<ProductModel>? = Array<ProductModel>()
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    //MARK: View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getProductList()
        setupSearchBar()
    }
    
    //MARK: Private methods
    
    private func setupSearchBar() {
        resultSearchController.searchResultsUpdater = self
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchBar.barTintColor = AppConstants.RED_COLOR
        headerView.addSubview(resultSearchController.searchBar)
        
        definesPresentationContext = false
    }

    //MARK: API calls
    
    private func getProductList() {
        guard Reachability.isConnectedToNetwork() else {
            let errorTextToDisplay = "Please check your internet connectivity & try again."
            let alertController = UIAlertController(title: "No Internet!", message: errorTextToDisplay, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok!", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        ProgressView.sharedInstance.showProgressViewNow()
        let productNetworkAdapter = ProductNetworkAdapter()
        productNetworkAdapter.getProducts { (products, error) in
            self.productList = products
            DispatchQueue.main.async {
                ProgressView.sharedInstance.hideProgressView()
                self.productListCollectionView.reloadData()                
            }            
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard productList != nil || filteredProductList!.count > 0 else {
            return 0
        }
        
        if resultSearchController.isActive {
            return filteredProductList!.count
        } else {
            return productList!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        cell.productNameLabel.backgroundColor = AppConstants.TRANSLUCENT_COLOR
        cell.productNameLabel.textColor = .white
        cell.productNameLabel.layer.masksToBounds = true
        cell.productNameLabel.layer.cornerRadius = 10
        
        cell.productPriceLabel.backgroundColor = .white
        cell.productPriceLabel.textColor = AppConstants.RED_COLOR
        cell.productPriceLabel.layer.masksToBounds = true
        cell.productPriceLabel.layer.cornerRadius = 10
        
        if self.resultSearchController.isActive {
            guard let products = filteredProductList, let thumbnailURLs = products[indexPath.row].productThumbnailURLs else {
                return UICollectionViewCell()
            }
            
            cell.productImageView.sd_setImage(with: URL(string: thumbnailURLs[0]), placeholderImage: UIImage(named: "img_placeholder"))
            cell.productNameLabel.text = products[indexPath.row].productName
            cell.productPriceLabel.text = "\(String(describing: products[indexPath.row].productPrice!))"
            
        } else {
            guard let products = productList, let thumbnailURLs = products[indexPath.row].productThumbnailURLs else {
                return UICollectionViewCell()
            }
            
            cell.productImageView.sd_setImage(with: URL(string: thumbnailURLs[0]), placeholderImage: UIImage(named: "img_placeholder"))
            cell.productNameLabel.text = products[indexPath.row].productName
            cell.productPriceLabel.text = " \(String(describing: products[indexPath.row].productPrice!)) "
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 2
        let collectionViewWidth = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: ((collectionViewWidth/numberOfColumns) - (xInsets + cellSpacing)), height: (collectionViewWidth/numberOfColumns) - (xInsets + cellSpacing))
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredProductList!.removeAll(keepingCapacity: false)
        let searchText = searchController.searchBar.text!
        
        for item in productList! {
            if (item.productName?.starts(with: searchText))! {
                filteredProductList!.append(item)
            }
        }
        productListCollectionView.reloadData()
    }
}
