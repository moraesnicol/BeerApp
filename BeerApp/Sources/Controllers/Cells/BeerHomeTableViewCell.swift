//
//  BeerHomeTableViewCell.swift
//  BeerApp
//
//  Created by Gabriel on 29/09/21.
//

import UIKit
import Kingfisher

class BeerHomeTableViewCell: UITableViewCell {

    lazy var beerImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "placeholder")
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Title"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "SubTitle"
        label.textColor = .primary
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupUiCell()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        beerImageView.image = UIImage(named: "placeholder")
        beerImageView.kf.cancelDownloadTask()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    func setupUiCell() {
        backgroundColor = .clear
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.clear.cgColor
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 12
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setCellWithValuesOf(_ beer: BeerModelApi) {
        let beerImgUrl: String? = beer.image_url ?? ""
        let baseUrl = beerImgUrl
        let imagePlaceHolder = UIImageView()
        imagePlaceHolder.contentMode = .scaleAspectFit
        imagePlaceHolder.image = UIImage(named: "placeholder")
        
        DispatchQueue.main.async {
            
            guard let url = URL(string: baseUrl ?? "" ) else { return }
            let resource = ImageResource(downloadURL: url, cacheKey: beer.image_url)
            let placeholder = imagePlaceHolder.image
            self.beerImageView.kf.setImage(with: resource, placeholder: placeholder)
            
            if let titleOptional = beer.name {
                let beerTitle = titleOptional
                self.titleLabel.text = beerTitle
            }
            
            if let subTitleOptional = beer.tagline{
                let beerSubTitle = subTitleOptional
                self.subTitleLabel.text = beerSubTitle
            }
            
        }
    }
    
}

extension BeerHomeTableViewCell: CodeView {
    
    public func setupView() {
        setupHierarchy()
        setupConstraints()
        setupAdditionalConfigurations()
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(beerImageView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            beerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            beerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            beerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            beerImageView.widthAnchor.constraint(equalToConstant:115),
            beerImageView.heightAnchor.constraint(equalToConstant: 192),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subTitleLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
    }
    
    func setupAdditionalConfigurations() {
        
    }
    
}
