//
//  AnimeTableViewCell.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {
    static let cellID = "AnimeTableViewCell"
        
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    private lazy var titleLbl: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure(anime: Anime) {
        let editedSlugText = anime.attributes?.slug?.replacingOccurrences(of: "-", with: " ")
        titleLbl.text = editedSlugText?.capitalizingFirstLetter()
    }
}

extension AnimeTableViewCell {
    func setup() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLbl)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    override func prepareForReuse() {
        titleLbl.text = nil
    }
}



