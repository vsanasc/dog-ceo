//
//  NetworkError.swift
//  DogCeoCommons
//
//  Created by Vitor on 03-04-21.
//

import Foundation

public enum NetworkError: Error {
    case encodeError
    case unknownError
    case httpError
    case urlError
}
