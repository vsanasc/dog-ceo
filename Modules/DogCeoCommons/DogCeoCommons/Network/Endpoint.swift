//
//  EndpointType.swift
//  DogCeoCommons
//
//  Created by Vitor on 03-04-21.
//

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

let BASEURL = "https://dog.ceo/api/"

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: NetworkHTTPMethod { get }
    var headers: HTTPHeaders { get }
}

public extension Endpoint {
    var baseURL: String {
        return BASEURL
    }
    var method: NetworkHTTPMethod { return .get }
    var headers: HTTPHeaders { return [:] }
    var fullpath: String {
        return "\(baseURL)\(path)"
    }
}
