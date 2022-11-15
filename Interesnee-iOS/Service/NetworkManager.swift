//
//  NetworkManager.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func fetchImages(query: String, pageNumber: Int, completion: @escaping (Result<ImageData, Error>) -> ())
}

struct NetworkManager: Networkable {

    var provider = MoyaProvider<API>()

    func fetchImages(query: String, pageNumber: Int, completion: @escaping (Result<ImageData, Error>) -> ()) {
        performRequest(target: .search(query: query, pageNumber: pageNumber), completion: completion)
    }
}

extension NetworkManager {

    private func performRequest<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
