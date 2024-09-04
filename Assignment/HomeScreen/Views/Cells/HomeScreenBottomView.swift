//
//  HomeScreenBottomView.swift
//  Assignment
//
//  Created by Urmila on 04/09/24.
//

import Foundation
import UIKit

class HomeScreenBottomView: UIViewController {
    private let viewModel: HomeScreenViewModel
    
    // Initialize with ViewModel
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    // Set up view and add stats label
    private func setupView() {
        view.backgroundColor = .white
        let statsLabel = createStatsLabel()
        view.addSubview(statsLabel)

        // Setup constraints
        NSLayoutConstraint.activate([
            statsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            statsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // Create and configure stats label
    private func createStatsLabel() -> UILabel {
        let statsLabel = UILabel()
        statsLabel.numberOfLines = 0 // Allows for multiple lines
        statsLabel.translatesAutoresizingMaskIntoConstraints = false
        statsLabel.attributedText = generateAttributedStatsText()
        statsLabel.font = UIFont.systemFont(ofSize: 16)
        statsLabel.textColor = UIColor.black
        return statsLabel
    }

    // Generate attributed text for stats label
    private func generateAttributedStatsText() -> NSAttributedString {
        let totalItemsText = "Total Items: \(viewModel.filteredItemsCount)"
        let topCharactersText = viewModel.topCharacterCounts
            .map { "\($0.character): \($0.count)" }
            .joined(separator: "\n")
        
        let attributedString = NSMutableAttributedString()
        
        // Define paragraph style with spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        paragraphStyle.paragraphSpacing = 16
        
        // Title
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 32),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]
        let titleString = NSAttributedString(
            string: "List Statistics:\n",
            attributes: titleAttributes
        )
        attributedString.append(titleString)
        
        // Total Items
        let totalItemsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.darkGray,
            .paragraphStyle: paragraphStyle
        ]
        let totalItemsString = NSAttributedString(
            string: "\(totalItemsText)\n",
            attributes: totalItemsAttributes
        )
        attributedString.append(totalItemsString)
        
        // Top Characters
        let topCharactersAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]
        let topCharactersTitle = NSAttributedString(
            string: "Top 3 Characters:\n",
            attributes: topCharactersAttributes
        )
        attributedString.append(topCharactersTitle)
        
        let topCharactersString = NSAttributedString(
            string: topCharactersText,
            attributes: topCharactersAttributes
        )
        attributedString.append(topCharactersString)
        
        return attributedString
    }

}
