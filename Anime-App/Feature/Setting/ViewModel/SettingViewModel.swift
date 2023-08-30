//
//  SettingViewModel.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit

class SettingViewModel {
    
    var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    lazy var appVersionTitle: String = {
        return appVersion ?? ""
    }()
    
    var settingsOptions: [Section] = []
}
