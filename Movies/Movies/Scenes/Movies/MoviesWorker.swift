//
//  MoviesWorker.swift
//  Movies
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright (c) 2018 Lorrayne Paraiso. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class MoviesWorker {
    func Movies(completionHandler: @escaping (Bool, String?) -> Void) {
        let isSuccessful = true
        let errorMessage: String? = "Some service error message."

        completionHandler(isSuccessful, errorMessage)
    }
}
