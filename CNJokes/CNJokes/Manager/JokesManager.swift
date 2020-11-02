//
//  JokesManager.swift
//  test
//
//  Created by SMMC on 31/10/2020.
//

import Foundation
import Alamofire

struct JokesManager {
   
    func fetchJokes(_ areExplicitJokesExcluded: Bool, completion: @escaping (Result<JokesModel, Error>) -> Void) {
        var excludeJokes = ""
        var path = Constants.API.endPoint
        
        if !areExplicitJokesExcluded {
            excludeJokes = Constants.API.typeExcludedJokes
            path = Constants.API.endPointExcludedJokes
        }
    
        let query = excludeJokes.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let urlString = String(format: path, query)
       
        AF.request(urlString).responseDecodable(of: JokesData.self, queue: .main, decoder: JSONDecoder()) { (response) in
            switch response.result {
                case .success(let jokesData):
                    let model = jokesData.model
                    completion(.success(model))
                case .failure(let error):
                    print("error:", error)
            }
        }
    }
}
