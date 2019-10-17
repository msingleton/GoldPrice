//
//  GoldPriceTests.swift
//  GoldPriceTests
//
//  Created by Michael Singleton on 10/4/19.
//  Copyright © 2019 Pickaxe LLC. All rights reserved.
//

import Quick
import Nimble
import GoldPrice

class GoldPriceTests: QuickSpec {
    override func spec() {
        describe("GoldPrice") {
            it("Returns the gold price") {
                var price: Double?
                
                CurrentGoldPrice { (result) -> Void in
                    switch result {
                    case .success(let currentPrice):
                        price = currentPrice
                    case .failure(let error):
                        expect(error).to(beNil())
                    }
                }
                
                expect(price).toEventually(beGreaterThan(0), timeout: 10)
            }
        }
    }
}

