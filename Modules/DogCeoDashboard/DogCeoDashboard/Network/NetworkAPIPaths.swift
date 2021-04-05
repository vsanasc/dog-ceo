//
//  NetworkAPIPaths.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import Foundation

public enum NetworkAPIPaths {
    static let baseURL = "https://dog.ceo/api/"
    case list
    case images(slug: String)

    func getURL() -> String {
        let base = NetworkAPIPaths.baseURL
        switch self {
        case .list:
            return "\(base)breeds/list"
        case .images(let slug):
            return "\(base)breed/\(slug)/images"
        }
    }
}
