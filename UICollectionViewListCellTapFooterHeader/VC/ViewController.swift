//
//  ViewController.swift
//  UICollectionViewListCellTapFooterHeader
//
//  Created by Viacheslav Loie on 29.07.2023.
//

import UIKit

class ViewController: UIViewController, SectionCollectionViewCellDelegate {
    
    // MARK: - SectionCollectionViewCellDelegate
    
    func didTapDisclosureButton(in cell: SectionCollectionViewCell, section: Int, state: UICellConfigurationState) {
        if let footer = collectionView.supplementaryView(forElementKind: ViewController.sectionFooterElementKind, at: IndexPath(row: 0, section: section)) as? SectionFooterReusableView {
            footer.isExpanded = state.isExpanded
        }
    }
    
    // MARK: - Properties
    
    static let sectionBackgroundDecorationElementKind = "section-background-element-kind"
    static let sectionFooterElementKind = "section-footer-element-kind"

    private struct Item: Hashable {
        let title: String?
        private let identifier = UUID()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    private var collectionView: UICollectionView! = nil
    weak var delegateInSpotlight: SectionFooterDelegate?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        applySnapshot()
    }
}

extension ViewController {
    
    // MARK: - Layout
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.showsSeparators = false
            config.headerMode = .firstItemInSection
            let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: ViewController.sectionBackgroundDecorationElementKind)
            sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 16, bottom: 0, trailing: 16)
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.decorationItems = [sectionBackgroundDecoration]
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: ViewController.sectionFooterElementKind, alignment: .bottom)
            section.boundarySupplementaryItems = [sectionFooter]
            return section
        }
        
        layout.register(SectionBackgroundDecorationViewColor.self, forDecorationViewOfKind: ViewController.sectionBackgroundDecorationElementKind)
        return layout
    }
}

extension ViewController {
    
    // MARK: - View Hierarchy Configuration
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
        
    @objc private func handleFooterTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let view = gestureRecognizer.view as? SectionFooterReusableView else {
            return
        }
        
        var sectionSnapshot = dataSource.snapshot(for: view.section)
        
        if view.isExpanded {
            sectionSnapshot.collapse([sectionSnapshot.rootItems.first!])
        } else {
            sectionSnapshot.expand([sectionSnapshot.rootItems.first!])
        }
        
        dataSource.apply(sectionSnapshot, to: view.section, animatingDifferences: true)
    }
    
    // MARK: - Data Source Configuration
    
    private func configureDataSource() {
        let headerCellSectionRegistration = UICollectionView.CellRegistration<SectionCollectionViewCell, Item> { (cell, indexPath, item) in
            cell.section = indexPath.section
            cell.configure(with: "To trigger a tap on the header, simply include it in the code and replicate the tap in the footer.")
            cell.delegate = self
            var content = UIListContentConfiguration.cell()
            content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 54, bottom: 16, trailing: 32)
            content.textProperties.font =  UIFont.systemFont(ofSize: 14, weight: .semibold)
            cell.contentConfiguration = content
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration(
            supplementaryNib: UINib(nibName: "InSpotlightSectionFooterCollectionReusableView", bundle:nil),
            elementKind: ViewController.sectionFooterElementKind) { (supplementaryView, string, indexPath) in
                
            guard let supplementaryView = supplementaryView as? SectionFooterReusableView else {
                return
            }
            supplementaryView.section = indexPath.section
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleFooterTapped(_:)))
            supplementaryView.addGestureRecognizer(tapRecognizer)
            supplementaryView.locationLabel.text = "New York"
            let sectionSnapshot = self.dataSource.snapshot(for: indexPath.section)
            supplementaryView.isExpanded  = sectionSnapshot.isExpanded(sectionSnapshot.rootItems.first!)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<DetailCollectionViewCell, Item> { [weak self] (cell, indexPath, item) in
            guard self != nil else { return }
            cell.configure(text: "To trigger a tap on the header, simply include it in the code and replicate the tap in the footer. - To trigger a tap on the header, simply include it in the code and replicate the tap in the footer - To trigger a tap on the header, simply include it in the code and replicate the tap in the footer ")
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerCellSectionRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        let sections = Array(0..<5)
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)

        for section in sections {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            let headerItem = Item(title: "Section \(section)")
            sectionSnapshot.append([headerItem])
            let items = Array(0..<1).map { Item(title: "Item \($0)") }
            sectionSnapshot.append(items, to: headerItem)
            dataSource.apply(sectionSnapshot, to: section, animatingDifferences: false)
        }
    }
}

