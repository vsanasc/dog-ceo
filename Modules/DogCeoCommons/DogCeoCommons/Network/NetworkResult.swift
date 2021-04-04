//
//  NetworkResult.swift
//  DogCeoCommons
//
//  Created by Vitor on 03-04-21.
//

public enum NetworkResult<T, E> where E: Error {
    case success(T)
    case error(E)
}
