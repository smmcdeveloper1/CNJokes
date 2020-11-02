//
//  AppConstants.swift
//  test
//
//  Created by SMMC on 01/11/2020.
//

import Foundation
import UIKit

struct Constants {
    struct API {
        static let endPoint = "https://api.icndb.com/jokes/random/20"
        static let endPointExcludedJokes = "https://api.icndb.com/jokes/random/20?exclude=%@"
        static let typeExcludedJokes = "explicit"
    }
    
    struct Content {
        static let tittleMessage = "Explict Jokes Filter"
        static let addExplicitJokesMessage = "Would you like to display the explict jokes?"
        static let excludeExplicitJokesMessage = "Would you like to exclude the explict jokes?"
        static let accept = "Accept"
        static let cancel = "Cancel"
    }
   
    struct identifiers {
        static let TableViewCellidentifier = "TableViewCell"
    }
}
