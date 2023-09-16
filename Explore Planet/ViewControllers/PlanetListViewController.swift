//
//  PlanetListViewController.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-15.
//

import UIKit
import RxSwift
import RxDataSources

class PlanetListViewController: UIViewController {
    
    private let viewModel: PlanetViewModel
    
    private let planetTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.register(PlanetCellView.self, forCellReuseIdentifier: PlanetCellView.indentifier)
        return tableView
    }()
    
    private let loaderView: UIView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.color = .gray
        view.hidesWhenStopped = true
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    private var datasource: RxTableViewSectionedReloadDataSource<PlanetSection> = {
        let dataSource = RxTableViewSectionedReloadDataSource<PlanetSection>(
            configureCell: { (_, tableView, indexPath, item) -> UITableViewCell in
                guard let cell: PlanetCellView = tableView.dequeueReusableCell(withIdentifier: PlanetCellView.indentifier, for: indexPath)
                        as? PlanetCellView
                else {
                    return UITableViewCell()
                }
                cell.viewData = item
                return cell
            }
        )
        return dataSource
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Planets"
        
        bindUI()
        bindObservers()
    }
    
    init(viewModel: PlanetViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension PlanetListViewController {
    
    func bindUI() {
        self.view.addSubview(planetTableView)
        self.view.addSubview(loaderView)
        
        
        let planetTableViewConstrains = [
            planetTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            planetTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            planetTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            planetTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        let loaderViewConstrains = [
            loaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 150),
            loaderView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(planetTableViewConstrains)
        NSLayoutConstraint.activate(loaderViewConstrains)
    }
    
    func bindObservers() {
        // Inputs
        viewModel.loadPlanets()
        
        // Outputs
        viewModel
            .planetsLoaded
            .observe(on: MainScheduler.instance)
            .bind(to: planetTableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        viewModel
            .showLoading
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] show in
                self?.loaderView.isHidden = !show
            }
            .disposed(by: disposeBag)
        
        planetTableView.rx
            .itemSelected
            .map { indexPath -> Planet? in
                guard let cell: PlanetCellView = self.planetTableView.cellForRow(at: indexPath) as? PlanetCellView else {
                    return nil
                }
                
                return cell.viewData
            }
            .compactMap { $0 }
            .subscribe { [weak self] planet in
                let planetDetailsViewModel = PlanetDetailsViewModel(model: planet)
                let viewController = PlanetDetailsViewController(viewModel: planetDetailsViewModel)
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
