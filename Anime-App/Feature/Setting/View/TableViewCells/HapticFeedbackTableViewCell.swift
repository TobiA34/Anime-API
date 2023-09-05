//
//  HapticFeedbackTableViewCell.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit
 
class HapticFeedbackTableViewCell: UITableViewCell {

    static let identifier = "HapticFeedbackTableViewCell"
    private let defaults = UserDefaults.standard

    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var settingLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    
    private lazy var hapticFeedbackSwitch: UISwitch = {
        let hapticFeedbackSwitch = UISwitch()
        hapticFeedbackSwitch.tintColor = .blue
        hapticFeedbackSwitch.isOn = false
        hapticFeedbackSwitch.addTarget(self, action: #selector(toggleHapticFeedback), for: .touchUpInside)
        return hapticFeedbackSwitch
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    @objc func toggleHapticFeedback() {
        if hapticFeedbackSwitch.isOn == true {
             print("haptic Feedback is on")
             defaults.set(true, forKey: UserDefaultsKeys.isHapticsEnabled.title)
         } else {
             UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isHapticsEnabled.title)
         }
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
        settingLbl.text = nil
        hapticFeedbackSwitch.isOn = false
    }

    
    func configure(with model: SwitchOption) {
            settingLbl.text = model.title
            iconImageView.image = model.icon
            iconContainerView.backgroundColor = model.iconBackgroundColour
            hapticFeedbackSwitch.isOn = model.isOn
        }
}

extension HapticFeedbackTableViewCell {
    func setup() {
        contentView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(settingLbl)
        contentView.clipsToBounds = true
        accessoryType = .none
        accessoryView = hapticFeedbackSwitch
        
        NSLayoutConstraint.activate([
            iconContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            iconContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            iconContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            iconContainerView.heightAnchor.constraint(equalToConstant: 50),
            iconContainerView.widthAnchor.constraint(equalToConstant: 32),

            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
 
            settingLbl.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            settingLbl.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 16),
            settingLbl.bottomAnchor.constraint(equalTo: self.iconContainerView.bottomAnchor)
            
        ])
      
    }
}
