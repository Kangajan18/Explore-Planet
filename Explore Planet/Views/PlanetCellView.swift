//
//  PlanetCellView.swift
//  Explore Planet
//
//  Created by kangajan kuganathan on 2023-09-16.
//

import UIKit
import Alamofire

public class PlanetCellView: UITableViewCell {
    
    public static let indentifier = "planetCell"
    
    private let planetNameLabel: UILabel = {
        let planetNameLabel = UILabel()
        planetNameLabel.font = .preferredFont(forTextStyle: .headline)
        planetNameLabel.textColor = .black
        planetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return planetNameLabel
    }()
    
    private let climateLabel: UILabel = {
        let climateLabel = UILabel()
        climateLabel.font = .preferredFont(forTextStyle: .subheadline)
        climateLabel.textColor = .gray
        climateLabel.translatesAutoresizingMaskIntoConstraints = false
        return climateLabel
    }()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let planetImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PlaceHolder"))
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let imageURL:String = "https://picsum.photos/seed"
    
    public var viewData: Planet? {
        didSet {
            if let viewData = viewData {
                config(viewData: viewData)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        applyConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}


private extension PlanetCellView {
    
    func config(viewData: Planet){
        self.planetNameLabel.text = viewData.name
        self.climateLabel.text = viewData.climate
        self.planetImageView.image = UIImage(named: "PlaceHolder")
        
        self.loadImage()
    }
    
    func setupUI(){
        mainStack.addArrangedSubview(planetImageView)
        mainStack.addArrangedSubview(contentStack)
        
        contentStack.addArrangedSubview(planetNameLabel)
        contentStack.addArrangedSubview(climateLabel)
        
        contentView.addSubview(mainStack)
    }
    
    func applyConstrains(){
        let mainStackConstrains = [
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        let planetImageViewConstrains = [
            planetImageView.widthAnchor.constraint(equalToConstant: 70),
            planetImageView.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(mainStackConstrains)
        NSLayoutConstraint.activate(planetImageViewConstrains)
    }
    
    // Download & Load image from URL
    func loadImage(){
        let randomSeed = Int.random(in: 1...1000)
        let randomImageURL = "\(imageURL)/\(randomSeed)/200"
        
        // I have used Alamofire to download image from URL,
        AF.request(randomImageURL,method: .get).response{ response in
            
            switch response.result {
            case .success(let responseData):
                if let imageData = responseData {
                    // Assign planet image from downloaded image source
                    self.planetImageView.image = UIImage(data: imageData)
                }
            case .failure(_):
                // assign placeholder image if image not loaded from URL
                self.planetImageView.image = UIImage(named: "PlaceHolder")
            }
            
        }
    }
}
