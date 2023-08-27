//
//  SettingsViewController.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 27/08/2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 32
        return stackView
    }()
    
    private lazy var animeImageView: UIImageView = {
        let animeImageView = UIImageView()
        animeImageView.image = UIImage(named: "gundam")
        animeImageView.contentMode = .scaleAspectFit
        animeImageView.translatesAutoresizingMaskIntoConstraints = false
        return animeImageView
    }()
    
    private lazy var hapticFeedBackStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var audioStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var appVersionLbl: UILabel = {
        let appVersionLbl = UILabel()
        appVersionLbl.translatesAutoresizingMaskIntoConstraints = false
        appVersionLbl.textColor = .black
        return appVersionLbl
    }()
    
    private lazy var hapticFeedbackLbl: UILabel = {
        let hapticFeedbackLbl = UILabel()
        hapticFeedbackLbl.translatesAutoresizingMaskIntoConstraints = false
        hapticFeedbackLbl.textColor = .black
        hapticFeedbackLbl.text =  "haptic"
        hapticFeedbackLbl.font = .init(name: "", size: 14)
        return hapticFeedbackLbl
    }()
    
    
    private lazy var audioLbl: UILabel = {
        let audioLbl = UILabel()
        audioLbl.translatesAutoresizingMaskIntoConstraints = false
        audioLbl.textColor = .black
        audioLbl.text =  "Audio"
        audioLbl.font = .init(name: "", size: 14)
        return audioLbl
    }()
    
    private lazy var hapticFeedbackSwitch: UISwitch = {
        let hapticFeedbackSwitch = UISwitch()
        hapticFeedbackSwitch.translatesAutoresizingMaskIntoConstraints = false
        hapticFeedbackSwitch.isOn = false
        hapticFeedbackSwitch.addTarget(self, action: #selector(toggleHapticFeedback), for: .touchUpInside)
        return hapticFeedbackSwitch
    }()
    
    private lazy var audioSwitch: UISwitch = {
        let audioSwitch = UISwitch()
        audioSwitch.addTarget(self, action: #selector(toggleAudio), for: .touchUpInside)
        audioSwitch.translatesAutoresizingMaskIntoConstraints = false
        return audioSwitch
    }()
    
    @objc func toggleHapticFeedback() {
        if hapticFeedbackSwitch.isOn == true {
            print("haptic Feedback is on")
            defaults.set(true, forKey: "UseHaptic")
        } else {
            UserDefaults.standard.set(false, forKey: "UseHaptic")
            guard let appDomain = Bundle.main.bundleIdentifier else { return }
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.removeObject(forKey: "UseHaptic")
        }
    }
    
    @objc func toggleAudio() {
        if audioSwitch.isOn == true {
            let audioIsOn = audioSwitch.isOn == true
            print("Audio is on")
            defaults.set(audioIsOn, forKey: "UseAudio")
        } else {
            guard let appDomain = Bundle.main.bundleIdentifier else { return }
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
            UserDefaults.standard.removeObject(forKey: "UseAudio")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
     }


}

extension SettingsViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "Setting"
        
        stackView.addArrangedSubview(animeImageView)
        stackView.addArrangedSubview(appVersionLbl)

        stackView.addArrangedSubview(hapticFeedBackStackView)
        hapticFeedBackStackView.addArrangedSubview(hapticFeedbackLbl)
        hapticFeedBackStackView.addArrangedSubview(hapticFeedbackSwitch)
        
        stackView.addArrangedSubview(audioStackView)
        audioStackView.addArrangedSubview(audioLbl)
        audioStackView.addArrangedSubview(audioSwitch)
        
        
        if traitCollection.userInterfaceIdiom == .mac {
            hapticFeedbackSwitch.title = "Haptic FeedBack"
            audioSwitch.title = "Audio"
        }
        if let appVersionTitle = appVersion {
            appVersionLbl.text = "App Version: \(appVersionTitle)"
        }
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -24),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -24),
            animeImageView.heightAnchor.constraint(equalToConstant: 44),
            animeImageView.widthAnchor.constraint(equalToConstant: 44),
         ])
    }
}

enum ButtonSounds{
    case button1
    case button7
}

extension ButtonSounds {
    var title: String {
        switch self {
        case .button1:
            return "Button1"
        case .button7:
            return "Button7"
        }
    }
}
