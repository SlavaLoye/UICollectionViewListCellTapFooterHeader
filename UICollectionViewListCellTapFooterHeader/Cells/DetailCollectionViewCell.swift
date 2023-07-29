//
//  InSpotlightDetailCollectionViewCell.swift
//  UICollectionViewListCellTapFooterHeader
//
//  Created by Viacheslav Loie on 29.07.2023.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }

    // MARK: - Subview Configuration
    
    private func configureSubviews() {
        contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Cell Configuration
    
    func configure(text: String) {
        textLabel.text = text
    }
}

