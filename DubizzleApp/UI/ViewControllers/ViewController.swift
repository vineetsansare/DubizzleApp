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
    private var productList: Array<ProductModel>?
    private var filteredProductList: Array<ProductModel>? = Array<ProductModel>()
    private var resultSearchController = UISearchController(searchResultsController: nil)
    
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
        
        if self.resultSearchController.isActive {
            guard let products = filteredProductList, let thumbnailURLs = products[indexPath.row].productThumbnailURLs else {
                return UICollectionViewCell()
            }
            
            cell.productImageView.sd_setImage(with: URL(string: thumbnailURLs[0]), placeholderImage: UIImage(named: "img_placeholder"))
            cell.productNameLabel.text = products[indexPath.row].productName
            cell.productNameLabel.textColor = .white
            
            cell.productPriceLabel.text = "\(String(describing: products[indexPath.row].productPrice!))"
            cell.productPriceLabel.textColor = .white
        } else {
            guard let products = productList, let thumbnailURLs = products[indexPath.row].productThumbnailURLs else {
                return UICollectionViewCell()
            }
            
            cell.productImageView.sd_setImage(with: URL(string: thumbnailURLs[0]), placeholderImage: UIImage(named: "img_placeholder"))
            cell.productNameLabel.text = products[indexPath.row].productName
            cell.productNameLabel.textColor = .white
            
            cell.productPriceLabel.text = "\(String(describing: products[indexPath.row].productPrice!))"
            cell.productPriceLabel.textColor = .white
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
