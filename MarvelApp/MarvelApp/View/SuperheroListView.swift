//
//  MasterViewController.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import UIKit
import Dip
import RxSwift

class SuperheroListView: UITableViewController, StoryboardInstantiatable {

    var viewModel : SuperheroListViewModel!
    let disposeBag = DisposeBag()
    
    var isInSplitViewPresentation: Bool { return splitViewController?.isCollapsed == false }
    
    override func viewDidLoad() {
        viewModel.fetchSuperheroes()
        setupObservers()
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.prefetchDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            showSuperheroDetails(segue)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        viewModel.selectHero(viewModel.superheroes.value[tableView.indexPathForSelectedRow!.row])
        
        if identifier == "showDetail" {
            return splitViewController?.isCollapsed ?? true
        }
        
        return true;
    }

    private func setupObservers() {
        viewModel.superheroes.asObservable()
            .subscribe(onNext: {
                _ in self.onFetchCompleted(with: nil)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(viewModel.superheroes.value.count + (viewModel.canLoadMore ? 1 : 0), 1)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingCell(for: indexPath) {
            return tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuperheroTableViewCell", for: indexPath) as! SuperheroTableViewCell
        cell.updateView(viewModel.superheroes.value[indexPath.row])
        cell.accessoryType = isInSplitViewPresentation ? .none : .disclosureIndicator
        
        return cell
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        if refreshControl?.isRefreshing == true {
            refreshControl!.endRefreshing()
        }
        
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    private func showSuperheroDetails(_ segue: UIStoryboardSegue) {
        guard
            let controller = (segue.destination as? UINavigationController)?.topViewController as? SuperheroDetailView
            else { return }
        
        controller.navigationItem.title = viewModel.selectedHero.value?.name
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            self.tableView.visibleCells.forEach {
                    $0.accessoryType = self.isInSplitViewPresentation ? .none : .disclosureIndicator
                }
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        viewModel.refresh()
    }
}

extension SuperheroListView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchSuperheroes()
        }
    }
}

private extension SuperheroListView {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.superheroes.value.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
