//
//  ChanceUtil.swift
//  Find Gem
//
//  Created by 윤범태 on 2023/03/27.
//

import Foundation

struct ChanceUtil {
    static func probability(_ probability: Double) -> Bool {
        return Double.random(in: 0...1) < probability
    }
}
