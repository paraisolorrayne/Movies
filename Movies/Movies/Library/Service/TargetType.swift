//
//  TargetType.swift
//  Movies
//
//  Created by Lorrayne Paraiso  on 29/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation
import Alamofire

enum TargetType: URLRequestConvertible {

    case image(size: Int, path: String)
    case movie(id: Int)
    case movieQuery(query: String, page: Int)
    case movieDiscover(page: Int)

    private var method: HTTPMethod {
        switch self {
        case .image, .movie, .movieQuery, .movieDiscover:
            return .get
        }
    }

    private var baseURL: URL {
        switch self {
        case .movie:
            return URL(string: "\(MovieServer.baseURL)?\(APIParameterKey.apiKey)=\(MovieServer.apiKey)")!
        case .image(let size, _):
            return URL(string: "\(MovieServer.imageURL)\(size)")!
        case .movieQuery(let query, let page):
            return URL(string: "\(MovieServer.baseURL)?\(APIParameterKey.apiKey)=\(MovieServer.apiKey)&\(APIParameterKey.query)=\(query)&\(APIParameterKey.page)=\(page)")!
        case .movieDiscover(let page):
            return URL(string: "\(MovieServer.baseURL)?\(APIParameterKey.apiKey)=\(MovieServer.apiKey)&\(APIParameterKey.page)=\(page)")!
        }
    }

    private var path: String {
        switch self {
        case .image(_, let path):
            return "\(path)"
        case .movie(let id):
            return "/movie/\(id)"
        case .movieQuery:
            return "/search/movie"
        case .movieDiscover:
            return "/discover/movie"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        return urlRequest
    }
}

