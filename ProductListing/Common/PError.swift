//
//  PError.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import Foundation

enum PError: Error, CustomStringConvertible {
    
    //Web Service errors
    case invalidURL
    case requestParameterError
    case noData
    case networkRequestFailed
    
    //Json Parsing errors
    case jsonParsingFailed
    
    //Unknown Error
    case unknown(String)
    
    
    var description: String {
    
        switch self {
            
        case .invalidURL:
            return "Invalid url"
            
        case .requestParameterError:
            return "Problem with api request parameter"
            
        case .noData:
            return "Record not available"
            
        case .networkRequestFailed:
            return "The network appears to be down."
            
        case .jsonParsingFailed:
            return "We're having trouble parsing weather data."
                        
        case .unknown (let errorDesc):
            return errorDesc.isEmpty ? "Unknown error" : errorDesc
            
        }
    }
}
