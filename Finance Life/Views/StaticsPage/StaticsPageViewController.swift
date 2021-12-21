//
//  StaticsPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol StaticsPageViewProtocol: AnyObject {
    
    func tableViewReloadData()

}

class StaticsPageViewController: UIViewController {
    
    @IBOutlet private var tableViewGruoped: UITableView!

	var presenter: StaticsPagePresenterProtocol = StaticsPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        


        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadingCoreDataModels()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }
}

extension StaticsPageViewController: StaticsPageViewProtocol {
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.tableViewGruoped.reloadData()
        }
        
    }
}

extension StaticsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.countSections()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.returnSectionsName(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.returnDictionery(for: indexPath)
        return cell
    }
    
    
}
