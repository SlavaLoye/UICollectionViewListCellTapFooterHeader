//
//  InSpotlightSectionFooterCollectionReusableView.swift
//  UICollectionViewListCellTapFooterHeader
//
//  Created by Viacheslav Loie on 29.07.2023.
//

import UIKit

protocol SectionFooterDelegate: AnyObject {
    func didTapFooter(section: Int)
}

class SectionFooterReusableView: UICollectionReusableView {

    // MARK: - Properties
    
    static let reuseIdentifier = "section-footer-reuse-identifier"
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!

    var section: Int = 0

    var isExpanded = false {
        didSet {
            if isExpanded {
                iconImage.image = UIImage(systemName: "arrow.up.circle.fill")
                openLabel.text = "Closed"
            } else {
                iconImage.image = UIImage(systemName: "arrow.down.circle.fill")
                openLabel.text = "Open"
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        // Perform any additional setup for the view here, if needed.
    }
}

