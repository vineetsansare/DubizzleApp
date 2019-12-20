//
//  ProductModel.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import Foundation

struct ProductModel: Codable {
    let created_at: String?
    let productPrice: String?
    let productName: String?
    let uniqueID: String?
    let productImageIDs: [String]?
    let productImageURLs: [String]?
    let productThumbnailURLs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case created_at
        case productPrice = "price"
        case productName = "name"
        case uniqueID = "uid"
        case productImageIDs = "image_ids"
        case productImageURLs = "image_urls"
        case productThumbnailURLs = "image_urls_thumbnails"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(created_at, forKey: .created_at)
        try container.encode(productPrice, forKey: .productPrice)
        try container.encode(productName, forKey: .productName)
        try container.encode(uniqueID, forKey: .uniqueID)
        try container.encode(productImageIDs, forKey: .productImageIDs)
        try container.encode(productImageURLs, forKey: .productImageURLs)
        try container.encode(productThumbnailURLs, forKey: .productThumbnailURLs)
    }
}
