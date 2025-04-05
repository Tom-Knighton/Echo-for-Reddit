//
//  SubredditCollectionView.swift
//  Subreddits
//
//  Created by Tom Knighton on 14/03/2025.
//

import SwiftUI
import Posts
import Models
import Design
import Env
import ComposableArchitecture

public typealias SubredditStore = StoreOf<SubredditFeature>

public struct SubredditCollectionView: UIViewControllerRepresentable {
    
    @Environment(\.theme) var theme: Theme
    let store: SubredditStore
    
    public init(with store: SubredditStore) {
        self.store = store
    }
    
    public func makeUIViewController(context: Context) -> SubredditCollectionViewController {
        let vc = SubredditCollectionViewController(theme: theme, initialPosts: store.posts)
        vc.delegate = context.coordinator
        
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: SubredditCollectionViewController, context: Context) {
        if uiViewController.theme.name != theme.name {
            uiViewController.updateTheme(to: theme)
        }
        
        uiViewController.updateData(with: store.posts)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(store: store)
    }
    
    public class Coordinator: NSObject, SubredditCollectionViewDelegate {
        let store: SubredditStore
        
        public init(store: SubredditStore) {
            self.store = store
        }
        
        func shouldLoadMore() {
            
        }
    }
}

public class SubredditCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Post>
    
    var theme: Theme
    var collectionView: UICollectionView?
    var dataSource: DataSource?
    
    weak var delegate: SubredditCollectionViewDelegate?
    
    public init(theme: Theme, initialPosts: [Post]) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let uiCollectionView = self.configureCollectionView()
        uiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(uiCollectionView)
        self.collectionView = uiCollectionView
        self.configureDataSource(for: uiCollectionView)
        
        self.updateTheme(to: theme)
        
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
        return uiCollectionView
    }
    
    func configureDataSource(for collectionView: UICollectionView) {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Post> { cell, indexPath, item in
            cell.contentConfiguration = UIHostingConfiguration { [weak self] in
                ListPostView(with: item)
                    .listRowInsets(.init())
                    .environment(\.theme, self?.theme ?? EchoLightTheme())
                    .transaction { transaction in
                        transaction.animation = nil
                    }
            }
            cell.contentView.preservesSuperviewLayoutMargins = false
            cell.contentView.layoutMargins = .zero
        }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    func updateData(with posts: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Post>()
        if snapshot.numberOfSections == 0 { snapshot.appendSections([0])}
        snapshot.appendItems(posts, toSection: 0)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    public func updateTheme(to theme: Theme) {
        UIView.performWithoutAnimation {
            self.theme = theme
            self.view.backgroundColor = .red
            collectionView?.backgroundView = nil
            collectionView?.backgroundColor = UIColor.red
            
            collectionView?.collectionViewLayout = configureLayout()
            collectionView?.reloadData()
        }
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { [weak self] sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.showsSeparators = false
            configuration.backgroundColor = UIColor(self?.theme.primaryBackground ?? .clear)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            section.contentInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)
            return section
        }
        
        return layout
    }
}
