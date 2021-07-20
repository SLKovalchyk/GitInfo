//
//  HomeViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

final class HomeViewController: BaseViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    private let pushCoordinator = TransitionCoordinator()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var searchBar: UISearchBar?
    private var isShowDetailEnable: Bool = false
    private var source = [Repository]()
    private var sortRules: [SortRule]?
    private var currentSortRule: SortRule? {
        didSet {
            self.getRepositoriesList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HomeTableViewCell.cellNib, forCellReuseIdentifier: HomeTableViewCell.id)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = isShowDetailEnable
        tableView.tableHeaderView = searchBar
        navigationItem.setImageAsTitle()
        navigationController?.delegate = pushCoordinator
        getRepositoriesList()
    }
    
    // MARK: - Get data methods -
    
    private func getRepositoriesList() {
        RepositoryWorker.shared.getRepositoryList(query: searchBar?.text,
                                                  sort: currentSortRule?.sortKey.rawValue)
        { [weak self] result, error in
            if let error = error {
                self?.showToastError(message: error.localizedDescription)
            }
            if let array = result {
                self?.source = array
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Configure view -
    
    func provideConfiguration(_ configuration: HomeViewConfiguration) {
        if configuration.isShowMenu {
            navigationItem.setLeftButtonType(type: .Menu, target: self)
        }
        
        if let rules = configuration.sortRules, rules.count > 0 {
            sortRules = rules
            navigationItem.setRightBarButtonItem(type: .Filter, target: self)
        }
        
        if configuration.isShowSearch {
            searchBar = UISearchBar()
            searchBar?.sizeToFit()
            searchBar?.delegate = self
            searchBar?.showsCancelButton = true
        }
        isShowDetailEnable = configuration.isShowDetailEnable
    }

    // MARK: - Filter methods -
    @objc func filterPresed() {
        guard let rules = sortRules, rules.count > 0 else { return }
        let actionSheet = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        rules.forEach { rule in
            actionSheet.addAction(UIAlertAction(title: rule.title + (currentSortRule == rule ? "  ✔️" : ""),
                                                style: .default) { _ in
                self.currentSortRule = rule
            })
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel) { _ in
            self.currentSortRule = nil
        })
        present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Navigation -
    
    private func showRepoDetail(_ repo: Repository) {
        let vc = RepositoryDetailsViewController(repository: repo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showUserInfo(_ user: Owner) {
        let vc = UserInfoViewController(user: user).wrapInNavigationController()
        present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.id)
                as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let repository = source[indexPath.row]
        cell.configure(repository)
        
        if let owner = repository.owner {
            cell.avatarTapHandler = { [weak self] in
                self?.showUserInfo(owner)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repository = source[indexPath.row]
        showRepoDetail(repository)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        getRepositoriesList()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        getRepositoriesList()
    }
}
