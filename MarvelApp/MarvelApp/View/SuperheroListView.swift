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
    
    override func viewDidLoad() {
        viewModel.initialize()
        setupObservers()
        super.viewDidLoad()
        
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
        return viewModel.totalSuperheroes
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if isLoadingCell(for: indexPath) {
            cell.textLabel!.text =  ""
        } else {
            cell.textLabel!.text =  viewModel.superheroes.value[indexPath.row].name
        }
        
        return cell
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
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
