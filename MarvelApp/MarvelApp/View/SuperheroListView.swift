//
//  MasterViewController.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import UIKit
import Dip

class SuperheroListView: UITableViewController, StoryboardInstantiatable {

    var viewModel : SuperheroListViewModel!
    
    override func viewDidLoad() {
        viewModel.initialize()
        super.viewDidLoad()
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

        cell.textLabel!.text =  viewModel.superheroes[indexPath.row].name
        return cell
    }
    
    private func showSuperheroDetails(_ segue: UIStoryboardSegue) {
        guard
            let indexPath = tableView.indexPathForSelectedRow,
            let controller = (segue.destination as? UINavigationController)?.topViewController as? SuperheroDetailView
            else { return }
        
        viewModel.selectHero(viewModel.superheroes[indexPath.row])
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
    }
}
