//
//  StatusData.swift
//  shoes
//
//  Created by 김동혁 on 2022/07/18.
//

import Foundation

struct StatusData: Codable {
    var currentMoney: UInt
    var currentDiamond: UInt
    var shoesPrice: UInt
    var upgradeProbablity: UInt
    var upgradeCost: UInt
    var level: Int
    var shoes: String
}
