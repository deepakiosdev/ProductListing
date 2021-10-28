//
//  NetworkRequest.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import Foundation

enum NetworkRequest {
    //List of api requests
    case getProductDetail
}

//MARK: Full NetworkRequestProtocol requiremnts(Cunstruct request parmaters)
extension NetworkRequest: NetworkRequestProtocol {
    
    var scheme: String {
        return Constants.Api.scheme
    }
    
    var host: String {
        return Constants.Api.host
    }
    
    var requestMethod: RequestMethod {
        return .get
    }
    
    var endPoint: String {
        switch self {
        case .getProductDetail:
            return "/api/v1/products"

        }
    }

    var parameters: [URLQueryItem] {
        
        switch self {
        case .getProductDetail:
            let query = [
                URLQueryItem(name: "business_slug", value: "gabbar"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "per_page", value: "6"),
                URLQueryItem(name: "search", value: "&")
            ]
            return query
        }

    }
    
    var body: Data? {
        nil
    }
}

//Create and configure URLRequest
extension NetworkRequest {
    
    func urlRequest() throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endPoint
        
        if !parameters.isEmpty {
            components.queryItems = parameters
        }
        
        guard let url = components.url else {
            throw  PError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        
        if let body = body {
            request.httpBody = body
        }
        print("Request fields: \(String(describing: request.allHTTPHeaderFields))")

        return request
        
    }
}
