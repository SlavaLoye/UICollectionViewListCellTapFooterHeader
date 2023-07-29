//
//  InSpotlightHeaderSectionCollectionViewCell.swift
//  UICollectionViewListCellTapFooterHeader
//
//  Created by Viacheslav Loie on 29.07.2023.
//

import UIKit

// Protocol to handle tap events on the disclosure button in the SectionCollectionViewCell
protocol SectionCollectionViewCellDelegate: AnyObject {
    func didTapDisclosureButton(in cell: SectionCollectionViewCell, section: Int, state: UICellConfigurationState)
}

class SectionCollectionViewCell: UICollectionViewListCell {
    
    // MARK: - Properties
    
    var section: Int = 0
    weak var delegate: SectionCollectionViewCellDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
        layoutMargins.right = 0.0
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        let options = UICellAccessory.OutlineDisclosureOptions(style: .header, tintColor: .clear) // Clear color for the outline disclosure accessory
        let outlineDisclosure = UICellAccessory.outlineDisclosure(options: options)
        accessories = [outlineDisclosure]
    }
    
    // MARK: - Cell Configuration
    
    func configure(with item: String) {
        titleLabel.text = item
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        if let currentConfiguration = contentConfiguration as? UIListContentConfiguration {
            var newConfiguration = currentConfiguration.updated(for: state)
            newConfiguration.text = titleLabel.text
            newConfiguration.textProperties.numberOfLines = state.isExpanded ? 2 : 2
            contentConfiguration = newConfiguration
            delegate?.didTapDisclosureButton(in: self, section: section, state: state)
        }
    }
}

