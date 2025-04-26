//
//  PostCollectionView.swift
//  Posts
//
//  Created by Tom Knighton on 11/04/2025.
//

import SwiftUI
import UIKit
import Models

public struct PostCollectionView: UIViewControllerRepresentable {
    
    let post: Post
    
    public init(post: Post) {
        self.post = post
    }
    
    public func makeUIViewController(context: Context) -> PostCollectionViewController {
        let viewController = PostCollectionViewController()
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: PostCollectionViewController, context: Context) {
        uiViewController.updateComments(with: ["Comment 1", "Comment 2", "Comment 3", "Comment 4", "Comment 5"])
        uiViewController.updatePosts(with: post)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(post: post)
    }
    
    public class Coordinator: NSObject {
        let post: Post
        
        public init(post: Post) {
            self.post = post
        }
    }
}

public class PostCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CollectionItem>
    
    enum CollectionItem: Hashable {
        case post(Post)
        case comment(String)
    }
    
    var collectionView: UICollectionView?
    var dataSource: DataSource?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let uiCollectionView = self.configureCollectionView()
        uiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(uiCollectionView)
        self.collectionView = uiCollectionView
        self.configureDataSource(for: uiCollectionView)
        
//        self.updateTheme(to: theme)
        
        NSLayoutConstraint.activate([
            uiCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            uiCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
    
    func configureCollectionView() -> UICollectionView {
        let uiCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        uiCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        uiCollectionView.delegate = self
        uiCollectionView.allowsSelection = false
        return uiCollectionView
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.showsSeparators = false
            //            configuration.backgroundColor = UIColor(self?.theme.primaryBackground ?? .clear)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            return section
        }
        
        return layout
    }
    
    func configureDataSource(for collectionView: UICollectionView) {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CollectionItem> { cell, indexPath, item in
            
            switch item {
            case let .post(post):
                cell.contentConfiguration = UIHostingConfiguration {
                    PostContentView(post: post)
                }
            case let .comment(comment):
                cell.contentConfiguration = UIHostingConfiguration {
                    Text(comment)
                }
            }
            
            cell.contentView.preservesSuperviewLayoutMargins = false
            cell.contentView.layoutMargins = .zero
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    func updatePosts(with post: Post) {
        var snapshot = dataSource?.snapshot() ?? NSDiffableDataSourceSnapshot<Int, CollectionItem>()
        if snapshot.numberOfSections < 2 { snapshot.appendSections([0, 1])}
        snapshot.appendItems([CollectionItem.post(post)], toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func updateComments(with comments: [String]) {
        var snapshot = dataSource?.snapshot() ?? NSDiffableDataSourceSnapshot<Int, CollectionItem>()
        if snapshot.numberOfSections < 2 { snapshot.appendSections([0, 1])}
        snapshot.appendItems(comments.map { CollectionItem.comment($0) }, toSection: 1)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
