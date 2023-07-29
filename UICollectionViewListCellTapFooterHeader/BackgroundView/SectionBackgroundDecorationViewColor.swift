//
//  SectionBackgroundDecorationViewColor.swift
//  UICollectionViewListCellTapFooterHeader
//
//  Created by Viacheslav Loie on 29.07.2023.
//


import UIKit

class SectionBackgroundDecorationViewColor: UICollectionReusableView {
    
    // Reusable identifier for the decoration view
    static let reuseIdentifier = "SectionBackgroundDecorationView"
    
    // View for the colored section background
    let coloredBackgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // Setup the views and constraints
    private func setupViews() {
        setShadowView()
        setShadowBackgroundSectionView()

        // Add coloredBackgroundView as a subview and configure its properties
        addSubview(coloredBackgroundView)
        coloredBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        coloredBackgroundView.layer.cornerRadius = 16
        coloredBackgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        // Define constraints for coloredBackgroundView
        NSLayoutConstraint.activate([
            coloredBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            coloredBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            coloredBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            coloredBackgroundView.widthAnchor.constraint(equalToConstant: 20)
        ])

        // Array of available colors
        let colors: [UIColor] = [#colorLiteral(red: 0.9647058845, green: 0.7764706016, blue: 0.4, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.2941176593, blue: 0.4117647119, alpha: 1), #colorLiteral(red: 0.4352941215, green: 0.6901960969, blue: 0.5411764979, alpha: 1)]

        // Select a random color from the array and set it as the background color for coloredBackgroundView
        coloredBackgroundView.backgroundColor = colors.randomElement()
    }
    
    // Set shadow properties for the view
    func setShadowView(shadowColor: UIColor = .black,
                       shadowRadius: CGFloat = 10,
                       shadowOpacity: Float = 0.1,
                       shadowOffsetWidth: Int = 0,
                       shadowOffsetHeight: Int = 0) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.drawsAsynchronously = true
    }
    
    // Set shadow and border properties for the section background view
    func setShadowBackgroundSectionView()  {
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0
        layer.cornerRadius = 24
        layer.shadowOpacity = 0.1
    }
}


