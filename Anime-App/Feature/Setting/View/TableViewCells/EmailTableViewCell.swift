//
//  EmailTableViewCell.swift
//  EmailTableViewCell
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit
protocol EmailFeedbackTableViewCellDelegate: AnyObject {
    func openEmail()
}


class EmailFeedbackTableViewCell: UITableViewCell {

    static let identifier = "EmailFeedbackTableViewCell"
    private weak var delegate: EmailFeedbackTableViewCellDelegate?

    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var trailingButton: UIButton = {
        let trailingButton = UIButton()
        trailingButton.sizeToFit()
        trailingButton.addTarget(self, action: #selector(openEmailScreen), for: .touchUpInside)
        return trailingButton
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    @objc func openEmailScreen() {
        delegate?.openEmail()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        iconContainerView.backgroundColor = nil
        emailLbl.text = nil
    }

    func configure(with model: Email, delegate: EmailFeedbackTableViewCellDelegate) {
            self.delegate = delegate
            emailLbl.text = model.title
            iconImageView.image = model.icon
            iconContainerView.backgroundColor = model.iconBackgroundColour
            trailingButton.setImage(model.buttonIcon, for: .normal)
        }
    }

extension EmailFeedbackTableViewCell {
    func setup() {
        contentView.addSubview(iconContainerView)
        contentView.addSubview(trailingButton)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(emailLbl)
        contentView.clipsToBounds = true
        accessoryType = .none
        accessoryView = trailingButton
        
        NSLayoutConstraint.activate([
            iconContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            iconContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            iconContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            iconContainerView.heightAnchor.constraint(equalToConstant: 50),
            iconContainerView.widthAnchor.constraint(equalToConstant: 32),

            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
 
            emailLbl.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            emailLbl.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 16),
            emailLbl.bottomAnchor.constraint(equalTo: self.iconContainerView.bottomAnchor),
        ])
      
    }
}
