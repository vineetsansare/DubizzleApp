//
//  NetworkConstants.swift
//  DubizzleApp
//
//  Created by Vineet Sansare on 12/20/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

struct NetworkConstants {
    static let baseURL: String = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
    
    enum ServerError: String {
        case NetworkUnreachable = "Network not reachable"
    }
}
