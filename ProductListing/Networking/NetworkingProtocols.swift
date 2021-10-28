//
//  NetworkingProtocols.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkRequestProtocol {
    var scheme: String { get }
    var host: String { get }
    var requestMethod: RequestMethod { get }
    var endPoint: String { get }
    var parameters: [URLQueryItem] { get }
    var body: Data? { get }
}
