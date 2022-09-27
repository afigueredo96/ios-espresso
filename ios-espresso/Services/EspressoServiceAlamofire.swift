//
//  EspressoServiceAlamofire.swift
//  ios-espresso
//
//  Created by Aurelio Figueredo on 2022-09-25.
//

import Foundation
import Alamofire

class EspressoServiceAlamofire {
    
    
    func fetchOtherWay(url: URL, completion: @escaping (Result<ArticleList, AFError>) -> Void) {
        AF.request(url, method: .get).responseDecodable(of: ArticleList.self, completionHandler: { response in
            guard response.data != nil, response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            
            if let response = response.value {
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
        })
    }
    
    func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(resource.url).validate().responseDecodable(of: T.self) { response in
            guard response.data != nil, response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            
            if let response = response.value {
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
        }
    }
}
