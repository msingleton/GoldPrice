//
//  Quandl.swift
//  GoldPrice
//
//  Created by Michael Singleton on 10/14/19.
//  Copyright © 2019 Pickaxe LLC. All rights reserved.
//

import Foundation

enum QuandlDataElement: Decodable {
    case string(String)
    case double(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .string(container.decode(String.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .double(container.decode(Double.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(QuandlData.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
}

typealias QuandlData = [QuandlDataElement?]

struct QuandlDataset: Decodable {
    var name: String
    var data: [QuandlData]
}

struct QuandlError: Decodable {
    var code: String
    var message: String
}

struct QuandlResponse: Decodable {
    var dataset: QuandlDataset?
    var quandlError: QuandlError?
}
