//
//  ViewController.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import UIKit

class AnimeViewController: UIViewController {
    
    
    
    private var searchTask: DispatchWorkItem?
    private var animeViewModel = AnimeViewModel()
    private var page = 0
    private var isFetching = false
    private var isPaginating = false
    
    private lazy var customLoadingView : CustomSpinnerView = {
        let customLoadingView = CustomSpinnerView(title: "Fetching Animes")
        return customLoadingView
    }()
    
    private lazy var spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .blue
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(AnimeViewController.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.black
        let refreshControlTitle = "Refreshing Animes"
        let color = [ NSAttributedString.Key.foregroundColor: UIColor.black ]
        let attributedTitle = NSAttributedString(string: refreshControlTitle, attributes: color)
        refreshControl.attributedTitle = attributedTitle
        
        return refreshControl
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
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        resetAnime()
        refreshControl.endRefreshing()
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
            
            self?.customLoadingView.isHidden = false
            self?.animeViewModel.searchAnime(query: searchText) { res in
                
                switch res {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                }
                self?.customLoadingView.isHidden = true
                
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
        self.tableView.addSubview(self.refreshControl)
        
        customLoadingView.center = self.view.center
        self.view.addSubview(customLoadingView)
        customLoadingView.bringSubviewToFront(self.view)
        
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        spinner.bringSubviewToFront(self.view)
        
        NSLayoutConstraint.activate([
            
            customLoadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customLoadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    
    
    func resetAnime() {
        animeViewModel.resetAnime { res in
            switch res {
            case .success:
                self.tableView.reloadData()
            case .failure:
                print("Failed to reset")
            }
        }
    }
    
    func startPagination() {
        if isPaginating && !isFetching {
             self.spinner.startAnimating()
        }
        isPaginating = true
        animeViewModel.fetchAnime(page: page)  { [weak self] res in
            switch res {
            case .success:
                self?.tableView.reloadData()
                self?.page+=1
            case .failure:
                print("no more data")
            }
            self?.isPaginating = false
            self?.spinner.stopAnimating()
        }
    }
    
    
    func fetchAnime() {
        self.customLoadingView.startAnimating()
         UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            self.customLoadingView.alpha = 0
        }) { _ in
            self.customLoadingView.stopAnimating()
            self.spinner.stopAnimating()
        }
        self.isFetching = true
        animeViewModel.fetchAnime(page: page)  { [weak self] res in
            switch res {
            case .success:
                self?.tableView.reloadData()
            case .failure:
                print("no more data")
            }
            self?.isFetching = false
        }
    }
}

extension AnimeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height + 150 {
            startPagination()
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

