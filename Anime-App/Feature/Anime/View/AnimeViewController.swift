//
//  ViewController.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import UIKit

class AnimeViewController: UIViewController {
    
    var searchTask: DispatchWorkItem?
    private let animeViewModel = AnimeViewModel()
    private var animes: [Anime] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AnimeTableViewCell.self, forCellReuseIdentifier: AnimeTableViewCell.cellID)
        return tableView
    }()
 
    private let searchVc = UISearchController(searchResultsController: nil)
 
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
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
              //Use search text and perform the query
        
                self?.animeViewModel.searchAnime(query: searchText) { res in
                    switch res {
                    case .success(let anime):
                        self?.animes = anime
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()

                        }
                    case .failure(let error):
                        print(error)
                    }
                }
              DispatchQueue.main.async {
                //Update UI
              }
            }
          }
          
          self.searchTask = task
          
          //0.5 is the wait or idle time for execution of the function applyFilter
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: task)
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchVc.dismiss(animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

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
        getData()
        createSearchBar()
        
         view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant:  16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    func getData() {
        animeViewModel.getAnime { res in
            switch res {
            case .success(let anime):
                self.animes = anime
            case .failure(let error):
                print(error)
            }
        }

    }
}
 
extension AnimeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return animes.count
   }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let anime = animes[indexPath.row]
       let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.cellID,
                                                for: indexPath) as? AnimeTableViewCell
       cell?.configure(anime: anime)
       cell?.selectionStyle = .none
       return cell ?? UITableViewCell()
   }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let anime = animes[indexPath.row]
       let vc = AnimeDetailViewController(anime: anime)
       navigationController?.pushViewController(vc, animated: true)
   }
}
