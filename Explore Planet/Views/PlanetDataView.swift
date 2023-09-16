//
//  PlanetDataView.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-16.
//

import UIKit

public class PlanetDataView: UIView {
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 3
        titleLabel.font = .preferredFont(forTextStyle: .subheadline)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.numberOfLines = 3
        valueLabel.font = .preferredFont(forTextStyle: .subheadline)
        valueLabel.textColor = .blue
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        return valueLabel
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        bindUI()
    }
    
    public func setData(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PlanetDataView {
    
    func bindUI() {
        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
        
        let titleLabelConstrains = [
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        
        let valueLabelConstrains = [
            valueLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 20),
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstrains)
        NSLayoutConstraint.activate(valueLabelConstrains)
    }
}
