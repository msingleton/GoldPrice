//
//  GoldPriceTests.swift
//  GoldPriceTests
//
//  Created by Michael Singleton on 10/4/19.
//  Copyright © 2019 Pickaxe. All rights reserved.
//

import Quick
import Nimble
import GoldPrice

class GoldPriceTests: QuickSpec {
    override func spec() {
        describe("GoldPrice") {
            it("Returns the gold price") {
                let price = CurrentGoldPrice()
                
                expect(price).to(beGreaterThan(1))
                expect(price).to(beLessThan(1000000))
            }
        }
    }
}

