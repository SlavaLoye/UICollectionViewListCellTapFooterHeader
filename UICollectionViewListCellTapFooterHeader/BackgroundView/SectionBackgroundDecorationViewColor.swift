//
//  SectionBackgroundDecorationViewColor.swift
//  UICollectionViewListCellTapFooterHeader
//
//  Created by Viacheslav Loie on 29.07.2023.
//


import UIKit

class SectionBackgroundDecorationViewColor: UICollectionReusableView {
    
    static let reuseIdentifier = "SectionBackgroundDecorationView"

    let redView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        setShadowView()
        setShadowBackgroundSectionView()

        // Добавляем redView как подвид и настраиваем его параметры
        addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.layer.cornerRadius = 16
        redView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]

        // Определяем constraint для redView
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            redView.topAnchor.constraint(equalTo: topAnchor),
            redView.bottomAnchor.constraint(equalTo: bottomAnchor),
            redView.widthAnchor.constraint(equalToConstant: 20)
        ])

        // Массив с доступными цветами
        let colors: [UIColor] = [#colorLiteral(red: 0.9647058845, green: 0.7764706016, blue: 0.4, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.2941176593, blue: 0.4117647119, alpha: 1), #colorLiteral(red: 0.4352941215, green: 0.6901960969, blue: 0.5411764979, alpha: 1)]

        // Выбираем случайный цвет из массива и устанавливаем его для redView
        redView.backgroundColor = colors.randomElement()
    }
    
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
    
    func setShadowBackgroundSectionView()  {
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0
        layer.cornerRadius = 24
        layer.shadowOpacity = 0.1
    }
}


