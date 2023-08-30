//
//  AudioTableViewCell.swift
//  AudioTableViewCell
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit
 
class AudioTableViewCell: UITableViewCell {

    static let identifier = "AudioTableViewCell"
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
    
    
    private lazy var audioSwitch: UISwitch = {
        let audioSwitch = UISwitch()
        audioSwitch.isOn = false
        audioSwitch.addTarget(self, action: #selector(toggleAudio), for: .touchUpInside)
        return audioSwitch
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    @objc func toggleAudio() {
         if audioSwitch.isOn == true {
            defaults.set(true, forKey: UserDefaultsKeys.isAudioEnabled.title)
        } else {
            defaults.set(false, forKey:  UserDefaultsKeys.isAudioEnabled.title)
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
        audioSwitch.isOn = false
    }
    
    func configure(with model: SwitchOption) {
            settingLbl.text = model.title
            iconImageView.image = model.icon
            iconContainerView.backgroundColor = model.iconBackgroundColour
            audioSwitch.isOn = model.isOn
        }
}

extension AudioTableViewCell {
    func setup() {
        contentView.addSubview(iconContainerView)
        contentView.addSubview(audioSwitch)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(settingLbl)
        contentView.clipsToBounds = true
        accessoryType = .none
        accessoryView = audioSwitch
        
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
