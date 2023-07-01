//
//  NetworkManager.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let instance = NetworkManager()

    private init() {}

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        model: T.Type,
        completion: @escaping (Result<T, DataError>) -> Void
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameters
        )
        .responseString { responseString in
            print(responseString)
        }
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(DataError.networkingError(error.localizedDescription)))
            }
        }
    }
}
