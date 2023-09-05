//
//  VerticalStackView.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 30/08/2023.
//

import UIKit

class VerticalStackView: UIStackView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VerticalStackView {
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])

    }
}
