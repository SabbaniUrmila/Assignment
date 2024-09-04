//
//  HomeViewController.swift
//  Assignment
//
//  Created by Urmila on 04/09/24.
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    let viewModel = HomeScreenViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var autoScrollTimer: Timer?
    private let pageControl = UIPageControl()
    
    var items: [HomeCarouselItem] = [] {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = items.count
        }
    }

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height * 0.5
        )
        layout.minimumLineSpacing = 0
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
    }()
    
    private let searchBar = UISearchBar()
    private let listView = UITableView()
    private let floatingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        startAutoScroll()
        setupKeyboardNotifications()
        setupDismissKeyboardTap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        items = [
            HomeCarouselItem(imageName: "cutie"),
            HomeCarouselItem(imageName: "bluePic"),
            HomeCarouselItem(imageName: "images"),
            HomeCarouselItem(imageName: "rose"),
            HomeCarouselItem(imageName: "green"),
            HomeCarouselItem(imageName: "cutie"),
            HomeCarouselItem(imageName: "bluePic")
        ]
        setupCollectionView()
        setupSearchBar()
        setupListView()
        setupFloatingButton()
        setupPageControl()
        setupStackView()
        setupScrollView()
    }
    private func setupDismissKeyboardTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 8
        collectionView.backgroundColor = .clear
        collectionView.register(
            CarouselCell.self,
            forCellWithReuseIdentifier: CarouselCell.identifier
        )
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.delegate = self
    }
    
    private func setupListView() {
        listView.register(
            HomeListTableViewCell.self,
            forCellReuseIdentifier: HomeListTableViewCell.identifier
        )
        listView.dataSource = self
        listView.delegate = self
        listView.separatorStyle = .none
        listView.allowsSelection = false
        listView.showsVerticalScrollIndicator = false
    }
    
    private func setupFloatingButton() {
        floatingButton.setImage(UIImage(named: "dots"), for: .normal)
        floatingButton.backgroundColor = .blue
        floatingButton.layer.cornerRadius = 30
        floatingButton.addTarget(
            self,
            action: #selector(showBottomSheet),
            for: .touchUpInside
        )
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPageControl() {
        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(listView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60),
            floatingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

            pageControl.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$filteredListItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.listView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(
            timeInterval: 3.0,
            target: self,
            selector: #selector(autoScrollCarousel),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func autoScrollCarousel() {
        guard !items.isEmpty else { return }
        
        let visibleItems = collectionView.indexPathsForVisibleItems
        let currentIndexPath = visibleItems.first ?? IndexPath(item: 0, section: 0)
        var nextItem = currentIndexPath.item + 1
        
        if nextItem >= items.count {
            nextItem = 0
        }
        
        let nextIndexPath = IndexPath(item: nextItem, section: 0)
        collectionView.scrollToItem(
            at: nextIndexPath,
            at: .centeredHorizontally,
            animated: true
        )
        pageControl.currentPage = nextItem
    }
    
    @objc private func showBottomSheet() {
        let bottomSheet = HomeScreenBottomView(viewModel: viewModel)
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
            sheet.selectedDetentIdentifier = .medium
        }
        present(bottomSheet, animated: true, completion: nil)
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            scrollView.contentInset.bottom = keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.width
        let page = collectionView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(page))
    }
}
