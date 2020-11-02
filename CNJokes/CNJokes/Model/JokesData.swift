//
//  JokesData.swift
//  test
//
//  Created by SMMC on 31/10/2020.
//

import Foundation

struct JokesData: Decodable {
    let type: String
    let value: [Value]
    
    var model: JokesModel {
        return JokesModel(jokes: value)
    }
}

struct Value: Decodable {
    let id: Int
    let joke: String
}

struct JokesModel {
    let jokes: [Value]
}

