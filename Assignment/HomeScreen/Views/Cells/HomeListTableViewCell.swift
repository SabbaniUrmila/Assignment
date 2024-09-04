//
//  HomeListTableViewCell.swift
//  Assignment
//
//  Created by Urmila on 04/09/24.
//

import Foundation
import UIKit

class HomeListTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundPaddingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 209/255, green: 230/255, blue: 224/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backgroundPaddingView)
        contentView.layer.cornerRadius = 8
        contentView.addSubview(customImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            // Constraints for backgroundPaddingView
            backgroundPaddingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundPaddingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundPaddingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            backgroundPaddingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // Constraints for customImageView
            customImageView.leadingAnchor.constraint(equalTo: backgroundPaddingView.leadingAnchor, constant: 10),
            customImageView.centerYAnchor.constraint(equalTo: backgroundPaddingView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 60),
            customImageView.heightAnchor.constraint(equalToConstant: 60),
            
            // Constraints for titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundPaddingView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundPaddingView.centerYAnchor, constant: -15),
            
            // Constraints for subtitleLabel
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.centerYAnchor.constraint(equalTo: backgroundPaddingView.centerYAnchor, constant: 10)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: HomeListItem) {
        customImageView.image = UIImage(named: "rose")
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
