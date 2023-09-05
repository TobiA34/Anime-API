//
//  SettingsOption.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case hapticCell(item: SwitchOption)
    case audioCell(item: SwitchOption)
    case emailCell(item: Email)
    case aboutMeCell(item: AboutMe)
    case versionCell(item: Version)

}

struct Email {
    let title: String
    let icon: UIImage?
    let iconBackgroundColour: UIColor
    let buttonIcon: UIImage?
}

struct Version {
    let title: String
}

struct AboutMe {
    let title: String
}

struct Contact {
    let title: String
    let icon: UIImage?
    let iconBackgroundColour: UIColor
 }

struct SwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColour: UIColor
    var isOn: Bool
}
 
