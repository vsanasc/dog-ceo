//
//  URLSessionNetworkRequestAPI.swift
//  MusicSearchKit
//
//  Created by Vitor S do Nascimento on 08-11-19.
//

import DogCeoCommons

public class URLSessionManagerRequestAPI: ManagerRequestAPI {

    private let manager = URLSession.shared
    
    public init() { }

    public func fetch<T>(
        request: ManagerRequest,
        decode: T.Type,
        completion: @escaping (NetworkResult<T, Error>) -> Void
    ) where T : Decodable {
        guard let path = URL(string: request.url) else {
            completion(NetworkResult.error(NetworkError.urlError))
            return
        }

        var urlRequest = URLRequest(url: path)
        urlRequest.httpMethod = request.method.rawValue
        if request.method != .get {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: request.parameters, options: [])
        }

        // Build Auth Header
        for key in request.headers.keys {
            urlRequest.addValue(key, forHTTPHeaderField: request.headers[key]!)
        }

        // Send Data Task
        manager.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(NetworkResult.error(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
               200..<300 ~= httpResponse.statusCode,
               let data = data {
                let decoder = JSONDecoder()
                do {
                    let decoded = try decoder.decode(decode, from: data)
                    completion(NetworkResult.success(decoded))
                } catch {
                    completion(NetworkResult.error(NetworkError.encodeError))
                }
                return
            } else {
                completion(NetworkResult.error(NetworkError.httpError))
            }

        }.resume()
    }


//    public func request(_ url: String, completion: @escaping NetworkCompletion) {
//        request(url, method: .get, parameters: [:], headers: [:], completion: completion)
//    }
//
//    public func request(
//        _ url: String,
//        method: NetworkHTTPMethod,
//        parameters: Parameters,
//        headers: HTTPHeaders,
//        completion: @escaping NetworkCompletion
//    ) {
//
//
//    }
}
