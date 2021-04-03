//
//  NetworkAPI.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import Foundation

class NetworkAPI {

    private let urlSession = URLSession.shared

    func getBreedsList(
        onSuccess: @escaping ((_ response: BreedResponse) -> Void),
        onError: @escaping ((_ error: Error) -> Void)
    ) {
        let path: NetworkAPIPaths = .list
        urlSession.dataTask(
            with: .init(url: path.getURL()),
            completionHandler: { data, response, error in
                if let error = error {
                    onError(error)
                    return
                }

                if let data = data,
                   let response = response as? HTTPURLResponse,
                   response.statusCode == 200 {

                    let decoder = JSONDecoder()
                    do {
                        let decoded = try decoder.decode(BreedResponse.self, from: data)
                        onSuccess(decoded)
                    } catch {
                        onError(error)
                    }

                }

            }
        ).resume()

    }

    func getImagesList(
        breed: String,
        onSuccess: @escaping ((_ response: ImageResponse) -> Void),
        onError: @escaping ((_ error: Error) -> Void)
    ) {
        let path: NetworkAPIPaths = .images(slug: breed)
        urlSession.dataTask(
            with: .init(url: path.getURL()),
            completionHandler: { data, response, error in
                if let error = error {
                    onError(error)
                    return
                }

                if let data = data,
                   let response = response as? HTTPURLResponse,
                   response.statusCode == 200 {

                    let decoder = JSONDecoder()
                    do {
                        let decoded = try decoder.decode(ImageResponse.self, from: data)
                        onSuccess(decoded)
                    } catch {
                        onError(error)
                    }

                }
            }
        ).resume()

    }

}
