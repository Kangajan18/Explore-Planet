//
//  PlanetDetailsViewModel.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-16.
//

import Foundation
import RxSwift

public class PlanetDetailsViewModel {
    
    let model: Planet
    
    // Outputs
    let planetViewDataLoaded: PublishSubject<Planet> = PublishSubject<Planet>()
    
    init(model: Planet) {
        self.model = model
    }
    
    func loadDetails() {
        self.planetViewDataLoaded.onNext(self.model)
    }
}
