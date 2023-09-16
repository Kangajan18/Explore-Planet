//
//  PlanetDetailsViewController.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-16.
//

import UIKit
import RxSwift

public class PlanetDetailsViewController: UIViewController {
    
    private let viewModel: PlanetDetailsViewModel
    
    private let planetNameDataView: PlanetDataView = {
        let view = PlanetDataView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let orbitalPeriodDataView: PlanetDataView = {
        let view = PlanetDataView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let gravityDataView: PlanetDataView = {
        let view = PlanetDataView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private let disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        bindObservers()
    }
    
    init(viewModel: PlanetDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PlanetDetailsViewController {
    
    func bindUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(contentStackView)
        
        let contentStackViewConstrains = [
            contentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ]
        
        NSLayoutConstraint.activate(contentStackViewConstrains)
        
        contentStackView.addArrangedSubview(planetNameDataView)
        contentStackView.addArrangedSubview(orbitalPeriodDataView)
        contentStackView.addArrangedSubview(gravityDataView)
    }
    
    func bindObservers() {
        // Inputs
        viewModel.loadDetails()
        
        // Outputs
        viewModel
            .planetViewDataLoaded
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] planet in
                self?.title = planet.name
                
                self?.planetNameDataView.setData(title: "Planet Name", value: planet.name)
                self?.orbitalPeriodDataView.setData(title: "Orbital Period", value: planet.orbital_period)
                self?.gravityDataView.setData(title: "Gravity", value: planet.gravity)
            })
            .disposed(by: disposeBag)
    }
}
