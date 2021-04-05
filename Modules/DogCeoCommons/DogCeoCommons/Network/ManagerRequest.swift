//
//  ManagerRequest.swift
//  DogCeoCommons
//
//  Created by Vitor on 03-04-21.
//

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public struct ManagerRequest {
    public let url: String
    public var method: NetworkHTTPMethod
    public var parameters: Parameters
    public var headers: HTTPHeaders

    public init(
        url: String,
        method: NetworkHTTPMethod = .get,
        parameters: Parameters = [:],
        headers: HTTPHeaders = [:]
    ) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}
