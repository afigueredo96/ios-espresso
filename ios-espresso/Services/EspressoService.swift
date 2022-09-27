//
//  EspressoAPI.swift
//  ios-espresso
//
//  Created by Aurelio Figueredo on 2022-09-25.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case GET = "get"
    case POST = "post"
    case PUT = "put"
}

struct Resource<T: Codable> {
    let url: URL
    let httpMethod: HttpMethod = .GET
    let data: Data? = nil
}

class EspressoService {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var urlRequest: URLRequest = URLRequest(url: resource.url)
        urlRequest.httpMethod = resource.httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
