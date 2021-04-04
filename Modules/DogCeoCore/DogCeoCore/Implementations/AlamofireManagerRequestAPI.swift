//
//  AlamofireManagerRequestAPI.swift
//  DogCeoCore
//
//  Created by Vitor on 04-04-21.
//

import Alamofire
import DogCeoCommons

public class AlamofireManagerRequestAPI: ManagerRequestAPI {

    public init() { }

    public func fetch<T>(
        request: ManagerRequest,
        decode: T.Type,
        completion: @escaping (NetworkResult<T, Error>) -> Void
    ) where T : Decodable {

        let method = convertMethod(request.method)
        let headers = convertHeaders(request.headers)
        AF.request(
            request.url,
            method: method,
            parameters: request.parameters,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let decoded = try decoder.decode(decode, from: data)
                        completion(NetworkResult.success(decoded))
                    } catch {
                        completion(NetworkResult.error(NetworkError.encodeError))
                    }

                }
            case let .failure(error):
                completion(NetworkResult.error(error))
            }
        }

    }

    private func convertMethod(_ method: NetworkHTTPMethod) -> HTTPMethod {
        HTTPMethod(rawValue: method.rawValue)
    }

    private func convertHeaders(_ headers: DogCeoCommons.HTTPHeaders) -> Alamofire.HTTPHeaders {
        var items: [HTTPHeader] = []
        for key in headers.keys {
            items.append(.init(name: key, value: headers[key]!))
        }
        return Alamofire.HTTPHeaders(items)
    }

}
