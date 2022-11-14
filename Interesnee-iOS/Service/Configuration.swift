//
//  Configuration.swift
//  Interesnee-iOS
//
//  Created by Артем on 14.11.2022.
//

import Moya

enum API {
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
