//
//  AboutMeTableViewCell.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit

protocol AboutMeTableViewCellDelegate: AnyObject {
    func showAboutMe()
}

class AboutMeTableViewCell: UITableViewCell {

    static let identifier = "AboutMeTableViewCell"
    private weak var delegate: AboutMeTableViewCellDelegate?

    private lazy var aboutMeButton: UIButton = {
        let aboutMeButton = UIButton()
        aboutMeButton.setTitleColor(.systemBlue, for: .normal)
        aboutMeButton.translatesAutoresizingMaskIntoConstraints = false
        aboutMeButton.addTarget(self, action: #selector(openAboutMeScreen), for: .touchUpInside)
        return aboutMeButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @objc func openAboutMeScreen() {
        delegate?.showAboutMe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: AboutMe, delegate: AboutMeTableViewCellDelegate) {
            self.delegate = delegate
            aboutMeButton.setTitle(model.title, for: .normal)
        }
    }

extension AboutMeTableViewCell {
    func setup() {
        contentView.addSubview(aboutMeButton)
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            aboutMeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            aboutMeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            aboutMeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            aboutMeButton.heightAnchor.constraint(equalToConstant: 50),
            aboutMeButton.widthAnchor.constraint(equalToConstant: 100),
            
        ])
      
    }
}
