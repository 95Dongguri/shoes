//
//  StatusData.swift
//  shoes
//
//  Created by κΉλν on 2022/07/18.
//

import Foundation

struct Status: Codable {
    var currentMoney: UInt
    var currentDiamond: UInt
    var shoesPrice: UInt
    var upgradeProbablity: UInt
    var upgradeCost: UInt
    var level: Int
    var shoes: String
}
