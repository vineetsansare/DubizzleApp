//
//  ProductDetailsViewController.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/22/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import UIKit
import Foundation

class ProductDetailsViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productAddedOnLabel: UILabel!
    
    var product: ProductModel!
    var image: UIImage?
    
    //MARK: View Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK: Private methods
    
    private func setupUI() {
        productImage.image = self.image
        productPriceLabel.text = product.productPrice != nil ? ("Price - " + product.productPrice!) : ""
        productPriceLabel.backgroundColor = AppConstants.RED_COLOR
        productPriceLabel.textColor = .white
        productPriceLabel.layer.cornerRadius = 10
        productPriceLabel.layer.masksToBounds = true
        
        productNameLabel.text = product.productName != nil ? ("Product Name - " + product.productName!) : ""
        productNameLabel.backgroundColor = AppConstants.TRANSLUCENT_COLOR
        productNameLabel.textColor = .white
        productNameLabel.layer.cornerRadius = 10
        productNameLabel.layer.masksToBounds = true
        
        productAddedOnLabel.text = product.created_at != nil ? ("Added on - " + product.created_at!) : ""
        productAddedOnLabel.backgroundColor = AppConstants.TRANSLUCENT_COLOR
        productAddedOnLabel.textColor = .white
        productAddedOnLabel.layer.cornerRadius = 5
        productAddedOnLabel.layer.masksToBounds = true
    }    
}
