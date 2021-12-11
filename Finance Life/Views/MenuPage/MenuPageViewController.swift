//
//  MenuPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol MenuPageViewProtocol: AnyObject {
    func tableViewReloadData()
    
    func showStatics()
    func showGain()
    func showExpense()
    func showAccounts()
    
    
}

class MenuPageViewController: UIViewController {
    
    @IBOutlet private weak var accountLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: MenuPagePresenterProtocol = MenuPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    @IBAction private func buttonBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension MenuPageViewController: MenuPageViewProtocol {
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func showStatics() {
        let storyboard = UIStoryboard(name: "StaticsPage", bundle: Bundle.main)
        guard let vcStatics = storyboard.instantiateViewController(withIdentifier: "StaticsPageViewController") as? StaticsPageViewController else { return }
        navigationController?.pushViewController(vcStatics, animated: true)
    }
    
    func showAccounts() {
        let storyboard = UIStoryboard(name: "AccountsPage", bundle: Bundle.main)
        guard let vcStatics = storyboard.instantiateViewController(withIdentifier: "AccountsPageViewController") as? AccountsPageViewController else { return }
        navigationController?.pushViewController(vcStatics, animated: true)        
    }
    
    func showGain() {
        let storyboard = UIStoryboard(name: "GainsPage", bundle: Bundle.main)
        guard let vcStatics = storyboard.instantiateViewController(withIdentifier: "GainsPageViewController") as? GainsPageViewController else { return }
        navigationController?.pushViewController(vcStatics, animated: true)
    }
    
    func showExpense() {
        let storyboard = UIStoryboard(name: "ExpensesPage", bundle: Bundle.main)
        guard let vcStatics = storyboard.instantiateViewController(withIdentifier: "ExpensesPageViewController") as? ExpensesPageViewController else { return }
        navigationController?.pushViewController(vcStatics, animated: true)    }
    
}

extension MenuPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberCellOnTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.nameOnMenu(for: indexPath)
        cell.backgroundColor = .systemGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.switchSelectCell(for: indexPath)
        
        
    }
    
    
    
    
}
