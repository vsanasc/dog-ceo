//
//  ManagerRequest.swift
//  DogCeoCommons
//
//  Created by Vitor on 03-04-21.
//

public struct ManagerRequest {
    let url: String
    var method: NetworkHTTPMethod
    var parameters: Parameters
    var headers: HTTPHeaders

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
