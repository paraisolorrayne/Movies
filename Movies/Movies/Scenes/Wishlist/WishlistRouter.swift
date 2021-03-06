//
//  WishlistRouter.swift
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

protocol WishlistRoutingLogic {
    func routeToSomewhere()
}

protocol WishlistDataPassing {
    var dataStore: WishlistDataStore? { get }
}

class WishlistRouter: NSObject, WishlistRoutingLogic, WishlistDataPassing {
    var viewController: WishlistViewController?
    var dataStore: WishlistDataStore?

    // MARK: Routing

    func routeToSomewhere() {
        routeToSomewhere(segue: nil)
    }

    func routeToSomewhere(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! WishlistViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataTo(&destinationDS, from: dataStore!)
        }
        else {
            let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SomewhereViewController") as! WishlistViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataTo(&destinationDS, from: dataStore!)
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

    // MARK: Data Passing

    func passDataTo(_ destinationDS: inout WishlistDataStore, from sourceDS: WishlistDataStore) {
        destinationDS.attribute = sourceDS.attribute
    }
}
