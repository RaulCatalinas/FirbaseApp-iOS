//
//  Storyboard+IDs.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case home = "HomeScreen"

    var instance: UIStoryboard {
        UIStoryboard(name: rawValue, bundle: nil)
    }
}
