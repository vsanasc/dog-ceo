//
//  NetworkRouter.swift
//  DogCeoCommons
//
//  Created by Vitor on 03-04-21.
//

public protocol ManagerRequestAPI {

    func fetch<T: Decodable>(
        request: ManagerRequest,
        decode: T.Type,
        completion: @escaping (NetworkResult<T, Error>) -> Void
    )

}
