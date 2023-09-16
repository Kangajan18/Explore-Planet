//
//  PlanetViewModel.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-15.
//

import Foundation
import RxSwift

public class PlanetViewModel {
        
    // Outputs
    let planetsLoaded: PublishSubject<[PlanetSection]> = PublishSubject<[PlanetSection]>()
    let showLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    let showError:PublishSubject<PlanetError> = PublishSubject()
    
    func loadPlanets() {
        showLoading.onNext(true)
        PlanetService.shared.getPlanets { [weak self] result in
            self?.showLoading.onNext(false)
            switch result{
            case let .success(data):
                self?.planetsLoaded.onNext([PlanetSection(header: "", items: data)])
            case let .failure(apiError):
                self?.showError.onNext(apiError)
            }
        }
    }
}
