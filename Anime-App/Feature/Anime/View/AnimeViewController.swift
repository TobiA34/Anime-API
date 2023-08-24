//
//  ViewController.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import UIKit

class AnimeViewController: UIViewController {
    
    
    
    var searchTask: DispatchWorkItem?
    private var animeViewModel = AnimeViewModel()
    private var page = 0
    private var isFetching = false
 
    private lazy var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        return spinner
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AnimeTableViewCell.self, forCellReuseIdentifier: AnimeTableViewCell.cellID)
        return tableView
    }()
    
    private let searchVc = UISearchController(searchResultsController: nil)
    
    init(_ viewModel: AnimeViewModel = AnimeViewModel()) {
        self.animeViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension AnimeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text?.lowercased(), !searchText.isEmpty else {
            return
        }
        
        guard let searchText = searchBar.text?.lowercased(), !searchText.isEmpty else {
            return
        }
        self.searchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
  
                self?.spinner.startAnimating()
                self?.animeViewModel.searchAnime(query: searchText) { res in
                    
                    switch res {
                    case .success:
                        self?.tableView.reloadData()
                    case .failure(let error):
                        self?.showAlert(title: "Error", message: error.localizedDescription)
                    }
                    self?.spinner.stopAnimating()
                    
                }
        }
        
        self.searchTask = task
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchVc.dismiss(animated: true)
    }
}

extension AnimeViewController {
    
    func createSearchBar() {
        navigationItem.searchController = searchVc
        searchVc.searchBar.delegate = self
    }
    
    
    func setup() {
        view.backgroundColor = .white
        title = "Anime"
        tableView.dataSource = self
        tableView.delegate = self
        fetchAnime()
        createSearchBar()
        view.addSubview(tableView)
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        spinner.bringSubviewToFront(self.view)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func fetchAnime() {
        self.isFetching = true
        self.spinner.startAnimating()
        animeViewModel.fetchAnime(page: page)  { [weak self] res in
            switch res {
            case .success:
                self?.tableView.reloadData()
             case .failure:
                print("no more data")
             }
            self?.spinner.stopAnimating()
            self?.isFetching = false
        }
    }
    
}


extension AnimeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !isFetching {
                page+=1
                fetchAnime()
            }
        }
    }
}


extension AnimeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeViewModel.animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let anime = animeViewModel.animes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.cellID,
                                                 for: indexPath) as? AnimeTableViewCell
        cell?.configure(anime: anime)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let anime = animeViewModel.animes[indexPath.row]
        let vc = AnimeDetailViewController(anime: anime)
        navigationController?.pushViewController(vc, animated: true)
    }
}


