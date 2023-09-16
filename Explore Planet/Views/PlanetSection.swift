//
//  PlanetSection.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-16.
//

import Foundation
import RxDataSources

/// Resource from https://benoitpasquier.com/advanced-concepts-uitableview-rxdatasource/
struct PlanetSection {
    var header: String
    var items: [Planet]
}

extension PlanetSection: SectionModelType {
    typealias Item = Planet
    
    init(original: PlanetSection, items: [Item]) {
        self = original
        self.items = items
    }
}
