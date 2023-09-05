//
//  AboutMeViewController.swift
//  CreateSettingsScreen
//
//  Created by Tobi Adegoroye on 29/08/2023.
//

import UIKit

class AboutMeViewController: UIViewController {

    private lazy var stackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 8
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var aboutMeImageView: UIImageView = {
        let aboutMeImageView = UIImageView()
        aboutMeImageView.translatesAutoresizingMaskIntoConstraints = false
        aboutMeImageView.contentMode = .scaleAspectFit
        aboutMeImageView.image = UIImage(named: "image1")
        return aboutMeImageView
    }()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About Me"
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()


    private lazy var githubLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Click to see my Github"
        label.isUserInteractionEnabled = true
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var aboutMeLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = """
                      I’m a Junior iOS Developer based in Manchester. I'm currently refactoring an iOS app previously built in UIKit to SwiftUI, this app allows you to create life goals that you want to achieve. I have more than one year of agency experience in my current role, developing iPhone and iPad apps in Swift and Objective-C.
                      
                      In my spare time, I read books and watch tutorials to learn new topics in iOS Development. My hobbies include watching Arsenal and I have always attended every game. Also, I enjoy cooking different types of food. Currently, I like making Tacos. I like traveling to different countries and visiting museums.
                      """
        
        label.numberOfLines = 0
        return label
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    @objc func labelClicked() {
        if let url = URL(string: "https://github.com/TobiA34") {
            UIApplication.shared.open(url)
        }
    }
 
    @objc func close() {
        dismiss(animated: true)
    }
    
   }

extension AboutMeViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(stackview)
        stackview.addArrangedSubview(aboutMeImageView)
        stackview.addArrangedSubview(githubLbl)
        stackview.addArrangedSubview(aboutMeLbl)
        navigationController?.navigationBar.prefersLargeTitles = true

        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        githubLbl.addGestureRecognizer(guestureRecognizer)
        title = "About Me"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close))

        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 48),
            stackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 8),
            stackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -8),
            stackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -48),
            
            aboutMeImageView.heightAnchor.constraint(equalToConstant: 250),
            aboutMeImageView.widthAnchor.constraint(equalToConstant: 250)
            
        ])
    }
}

