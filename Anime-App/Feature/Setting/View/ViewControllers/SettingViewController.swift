//
//  ViewController.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController {
    
    private let viewModel = SettingViewModel()
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(AudioTableViewCell.self, forCellReuseIdentifier: AudioTableViewCell.identifier)
        tableView.register(HapticFeedbackTableViewCell.self, forCellReuseIdentifier: HapticFeedbackTableViewCell.identifier)
        tableView.register(EmailFeedbackTableViewCell.self, forCellReuseIdentifier: EmailFeedbackTableViewCell.identifier)
        tableView.register(AboutMeTableViewCell.self, forCellReuseIdentifier: AboutMeTableViewCell.identifier)
        tableView.register(VersionTableViewCell.self, forCellReuseIdentifier: VersionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SettingViewController {
    
    func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "Setting"
        navigationController?.navigationBar.prefersLargeTitles = true

        guard let appVersionTitle = appVersion else { return }
        
        viewModel.settingsOptions.append(
            Section(title: "General", options: [
                .hapticCell(item: SwitchOption(title: "Haptic Feedback", icon: UIImage(systemName: "gear"), iconBackgroundColour: .systemRed,isOn: false)),
                .audioCell(item: SwitchOption(title: "Audio", icon: UIImage(systemName: "speaker.wave.3"), iconBackgroundColour: .systemRed, isOn: false)),
                
            ])
        )
        
        viewModel.settingsOptions.append(
            Section(title: "Contact", options: [
                .emailCell(item: Email(title: "Email", icon: UIImage(systemName: "mail"), iconBackgroundColour: .systemGreen, buttonIcon: UIImage(systemName: "greaterthan"))),
                
            ])
        )
        
        viewModel.settingsOptions.append(
            Section(title: "About", options: [
                .aboutMeCell(item: AboutMe(title: "About Me")),
                .versionCell(item: Version(title: "Version Number: \(appVersionTitle)"))
                
            ])
        )
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsOptions[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.settingsOptions[indexPath.section].options[indexPath.row]
        switch model.self {
        case .audioCell(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.identifier, for: indexPath) as? AudioTableViewCell
            cell?.configure(with: item)
            return cell ?? UITableViewCell()
        case .hapticCell(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: HapticFeedbackTableViewCell.identifier,for: indexPath) as? HapticFeedbackTableViewCell
            cell?.configure(with: item)
            return cell ?? UITableViewCell()
        case .emailCell(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: EmailFeedbackTableViewCell.identifier,for: indexPath) as? EmailFeedbackTableViewCell
            cell?.configure(with: item, delegate: self)
            return cell ?? UITableViewCell()
        case .aboutMeCell(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutMeTableViewCell.identifier,for: indexPath) as? AboutMeTableViewCell
            cell?.configure(with: item, delegate: self)
            return cell ?? UITableViewCell()
        case .versionCell(let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: VersionTableViewCell.identifier,for: indexPath) as? VersionTableViewCell
            cell?.configure(with: item)
            return cell ?? UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.settingsOptions.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = viewModel.settingsOptions[section]
        return section.title
    }
 
}

extension SettingViewController:  EmailFeedbackTableViewCellDelegate, AboutMeTableViewCellDelegate, MFMailComposeViewControllerDelegate {
    
    func openEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["friend@gmail.com"])
            mail.setMessageBody("Hello friend", isHTML: false)

            present(mail, animated: true)
        }
    }
    
    func showAboutMe() {
        let vc = AboutMeViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .popover
        self.present(nav, animated: true, completion: nil)
    }
    
}

enum UserDefaultsKeys {
    case isHapticsEnabled
    case isAudioEnabled
}

extension UserDefaultsKeys {
    var title: String {
        switch self {
        case .isHapticsEnabled:
            return "isHapticsEnabled"
        case .isAudioEnabled:
            return "isAudioEnabled"
        }
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
