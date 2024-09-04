//
//  HomeViewController+Extensions.swift
//  Assignment
//
//  Created by Urmila on 04/09/24.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredListItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: .greatestFiniteMagnitude)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeListTableViewCell.identifier, for: indexPath) as? HomeListTableViewCell else {
            fatalError("Unable to dequeue CustomTableViewCell")
        }
        
        let item = viewModel.filteredListItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as! CarouselCell
        let item = items[indexPath.item]
        if let image = UIImage(named: item.imageName) {
            cell.configure(with: image)
        } else {
            print("Error: Image not found for index \(indexPath.item)")
            cell.configure(with: UIImage(named: "placeholderImage")!)
        }
        return cell
    }
}
