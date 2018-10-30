//
//  Constants.swift
//  Movies
//
//  Created by Lorrayne Paraiso  on 29/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import Foundation

struct MovieServer {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageURL = "https://image.tmdb.org/t/p/w"
    static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
}

struct APIParameterKey {
    static let language = "language"
    static let includeAdult = "include_adult"
    static let includeVideo = "include_video"
    static let apiKey = "api_key"
    static let query = "query"
    static let page = "page"
    static let id = "id"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
