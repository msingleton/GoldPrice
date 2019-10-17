//
//  CurrentPrice.swift
//  GoldPrice
//
//  Created by Michael Singleton on 10/7/19.
//  Copyright © 2019 Pickaxe LLC. All rights reserved.
//

import Foundation

public enum ApiError: Error {
    case InvalidUrl
    case InvalidReponse
    case JSONDecodingError(Error)
    case RequestError(Error)
    case ResponseError(String)
}

public func CurrentGoldPrice(completion: @escaping (Result<Double, ApiError>) -> Void) {
    guard let url = URL(string: "https://www.quandl.com/api/v3/datasets/LBMA/GOLD.json?api_key=zDvj4rpxzu56oisi5xAr") else {
        completion(.failure(.InvalidUrl))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, _, error) -> Void in
        if let error = error {
            completion(.failure(.RequestError(error)))
            return
        }
        
        guard let data = data else {
            completion(.failure(.InvalidReponse))
            return
        }
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        var response: QuandlResponse
        do {
            response = try decoder.decode(QuandlResponse.self, from: data)
        } catch {
            completion(.failure(.JSONDecodingError(error)))
            return
        }
        
        if let error = response.quandlError {
            completion(.failure(.ResponseError(error.message)))
            return
        }
        
        guard let dataset = response.dataset else {
            completion(.failure(.InvalidReponse))
            return
        }
        
        // The 2nd index is the US (PM) data
        guard let mostRecentPrice = dataset.data[0][2] else {
            completion(.failure(.InvalidReponse))
            return
        }

        switch mostRecentPrice {
        case .double(let mostRecentPriceDouble):
            completion(.success(mostRecentPriceDouble))
        default:
            completion(.failure(.InvalidReponse))
        }
    })
    
    task.resume()
}
