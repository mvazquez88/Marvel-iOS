//
//  MasterViewController.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import UIKit

class SuperheroListView: UITableViewController {

    var superheroDetailView: SuperheroDetailView? = nil
    let viewModel = SuperheroListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split =  splitViewController {
            let controllers = split.viewControllers
            superheroDetailView = (controllers.last as! UINavigationController).topViewController as? SuperheroDetailView
        }
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

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.superheroes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel!.text =  viewModel.superheroes[indexPath.row].Name
        return cell
    }
    
    private func showSuperheroDetails(_ segue: UIStoryboardSegue) {
        guard
            let indexPath = tableView.indexPathForSelectedRow,
            let controller = (segue.destination as? UINavigationController)?.topViewController as? SuperheroDetailView
            else { return }
        
        controller.viewModel = SuperheroDetailViewModel(viewModel.superheroes[indexPath.row])
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
    }
}
