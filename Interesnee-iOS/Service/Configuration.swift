//
//  Configuration.swift
//  Interesnee-iOS
//
//  Created by Артем on 14.11.2022.
//

import Moya

enum API {
    static private let apiKey: String = "1da593812a1e7ba4678d3799f3e3cee3504a8e7f7a1733ec2101865bc2bf4d5e"
    case search(query: String, pageNumber: Int)
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://serpapi.com/") else { fatalError("Unable to decode url") }
        return url
    }

    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Moya.Task {
        switch self {
        case .search(let query, let pageNumber):
            return .requestParameters(
                parameters: [
                    "q" : query,
                    "api_key" : API.apiKey,
                    "tbm" : "isch",
                    "ijn" : pageNumber
                ],
                encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }


}
