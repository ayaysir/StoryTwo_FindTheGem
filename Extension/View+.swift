//
//  View+.swift
//  Find Gem
//
//  Created by 윤범태 on 2023/03/27.
//

import SwiftUI

extension View {
    // https://stackoverflow.com/questions/65191093/is-it-possible-to-flip-a-swiftui-view-vertically
    func flipped(_ axis: Axis = .horizontal, anchor: UnitPoint = .center) -> some View {
        switch axis {
        case .horizontal:
            return scaleEffect(CGSize(width: -1, height: 1), anchor: anchor)
        case .vertical:
            return scaleEffect(CGSize(width: 1, height: -1), anchor: anchor)
        }
    }
}
