//
//  Breed.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

struct BreedResponse: Decodable {
    let status: String
    let items: [String]

    enum CodingKeys: String, CodingKey {
        case status
        case items = "message"
    }
}
