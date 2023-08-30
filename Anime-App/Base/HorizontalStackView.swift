//
//  HorizontalStackView.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 30/08/2023.
//

import UIKit

class HorizontalStackView: UIStackView {
    
 
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
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

extension HorizontalStackView {
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])

    }
}
