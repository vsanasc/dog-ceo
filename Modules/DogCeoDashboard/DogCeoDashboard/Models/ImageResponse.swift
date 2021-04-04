//
//  ImageResponse.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

struct ImageResponse: Decodable {
    let status: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case status
        case images = "message"
    }
}
