//
//  MockManagerRequestAPI.swift
//  ExampleTests
//
//  Created by Vitor on 04-04-21.
//

import DogCeoCommons

class MockManagerRequestAPI: ManagerRequestAPI {

    // MARK: - Settings
    var response: Decodable?
    var error: Error = NetworkError.unknownError

    // MARK: - Methods
    func fetch<T>(
        request: ManagerRequest,
        decode: T.Type,
        completion: @escaping (NetworkResult<T, Error>) -> Void
    ) where T : Decodable {
        if let response = response,
           let responseDecodable = response as? T {
            completion(.success(responseDecodable))
        } else {
            completion(.error(error))
        }
    }


}
