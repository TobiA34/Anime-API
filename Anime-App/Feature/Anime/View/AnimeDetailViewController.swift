//
//  AnimeDetailViewController.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import UIKit
import Kingfisher


class AnimeDetailViewController: UIViewController {
    private lazy var mainStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fillEqually
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 8
        return stackview
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
 
    private lazy var synopsis: UITextView = {
        let synopsis = UITextView()
        synopsis.translatesAutoresizingMaskIntoConstraints = false
        synopsis.isEditable = false
        synopsis.font = UIFont(name: "", size: 24)
        synopsis.textColor = .black
        return synopsis
    }()
    
 
    
    
    private let anime: Anime
    init(anime: Anime) {
        self.anime = anime
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = anime.attributes?.slug
    }
}

extension AnimeDetailViewController {
    func setup() {
        view.backgroundColor = .white
        view.addSubview(mainStackview)
        mainStackview.addArrangedSubview(image)
         mainStackview.addArrangedSubview(synopsis)


        let url = URL(string: anime.attributes?.posterImage.medium ?? "")
        image.kf.setImage(with: url)
        
        synopsis.text = anime.attributes?.synopsis
 

        NSLayoutConstraint.activate([
            mainStackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            mainStackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            mainStackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            image.heightAnchor.constraint(equalToConstant: 300),
            image.widthAnchor.constraint(equalToConstant: 500)

        ])
    }
}
