//
//  VersionTableViewCell.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit

class VersionTableViewCell: UITableViewCell {

    static let identifier = "VersionTableViewCell"
 
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var versionLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        versionLbl.text = nil
    }

    func configure(with model: Version) {
            versionLbl.text = model.title
        }
    }

extension VersionTableViewCell {
    func setup() {
         contentView.addSubview(versionLbl)
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            versionLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            versionLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            versionLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            versionLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
 
        ])
      
    }
}
