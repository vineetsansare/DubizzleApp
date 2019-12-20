//
//  ViewController.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/19/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    private var productList: Array<ProductModel>?
    
    let images = [#imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail"), #imageLiteral(resourceName: "coffeemug_thumbnail")]
    
    //MARK: View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getProductList()
    }

    //MARK: API calls
    
    func getProductList() {
        let productNetworkAdapter = ProductNetworkAdapter()
        productNetworkAdapter.getProducts { (products, error) in
            self.productList = products
            DispatchQueue.main.async {
                self.productListCollectionView.reloadData()
            }            
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard productList != nil else {
            return 0
        }
        return productList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        guard let products = productList, let thumbnailURLs = products[indexPath.row].productThumbnailURLs else {
            return UICollectionViewCell()
        }
        
        cell.productImageView.image = UIImage(named: thumbnailURLs[0])
        cell.productNameLabel.text = products[indexPath.row].productName
        cell.productPriceLabel.text = "AED \(String(describing: products[indexPath.row].productPrice))"
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
