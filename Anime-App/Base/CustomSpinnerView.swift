//
//  CustomSpinnerView.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 25/08/2023.
//

import UIKit

class CustomSpinnerView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        stackView.layer.cornerRadius = 16
        stackView.spacing = 8
        return stackView
    }()

    private lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.textColor = .white
        titleLbl.text = "Fetching Anime"
        return titleLbl
    }()
    
    private lazy var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating(){
        spinner.startAnimating()
    }
    
}

extension CustomSpinnerView {
    func setup() {
        self.backgroundColor = .darkGray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(spinner)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.heightAnchor.constraint(equalToConstant: 100),
            self.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        
        titleLbl.text = title
    }
}
