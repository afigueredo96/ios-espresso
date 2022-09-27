//
//  Articles.swift
//  ios-espresso
//
//  Created by Aurelio Figueredo on 2022-09-25.
//

import Foundation

struct Miembros: Codable {
    var photo: String?
    var type: String?
    var id_member: String?
    var name: String?
    var is_defaulter: Int?
    var surname: String?
    var created_by: String?
    
//    enum CodingKeys: String, CodingKey {
//        case photo = "photo"
//        case type = "type"
//        case idMember = "id_member"
//        case name = "name"
//        case isDefaulter = "is_defaulter"
//        case surname = "surname"
//        case createdBy = "created_by"
//    }
}
struct ArticleList: Codable{
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
}

extension Article {
    static var all: Resource<ArticleList> = {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0984a24637d8469a96b90b2751eb0b72") else {
            fatalError()
        }
        
        return Resource<ArticleList>(url: url)
    }()
}
