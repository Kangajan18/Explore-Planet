//
//  PlanetService.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-15.
//

import Foundation
import Alamofire

struct PlanetResponse: Codable {
    let results: [Planet]
}

public class PlanetService {
    
    public static let shared: PlanetService = PlanetService()
    
    private let baseURL = "https://swapi.dev/api"
    
    /// Get Planets datas from API
    public func getPlanets(completionHandler: @escaping (Result<[Planet], PlanetError>) -> Void){
        let requestURL = "\(baseURL)/planets"
        let request = AF.request(requestURL).validate()
        
        request.responseDecodable(of: PlanetResponse.self) { (response) in
            switch response.result {
            case  .success:
                if let result = response.value {
                    completionHandler(.success(result.results))
                }else{
                    completionHandler(.failure(PlanetError.serverError(message: "Unable to retrive plant datas from response")))
                }
            case let .failure(error):
                completionHandler(.failure(PlanetError.serverError(message: error.localizedDescription)))
            }
            
        }
    }
}
