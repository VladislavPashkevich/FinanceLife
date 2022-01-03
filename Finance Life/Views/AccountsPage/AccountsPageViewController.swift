//
//  AccountsPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol AccountsPageViewProtocol: AnyObject {
    
    func reloadData()
    func addNewElementAccounts(to indexPath: IndexPath)
    func removeElementAccounts(to indexPath: IndexPath)
    func labelAddCategoryAccountHiddenTrue()
    func labelAddCategoryAccountHiddenFalse()

}

class AccountsPageViewController: UIViewController {
    
    @IBOutlet private weak var tableViewAccounts: UITableView!
    @IBOutlet private weak var labelPlaceholder: UILabel!
    
	var presenter: AccountsPagePresenterProtocol = AccountsPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()
        

        presenter.view = self
        presenter.viewDidLoad()
        
        tableViewAccounts.register(UINib(nibName: "TableCellAccounts", bundle: Bundle.main), forCellReuseIdentifier: "TableCellAccounts")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        presenter.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction private func addNewAccount() {
        let storyboard = UIStoryboard(name: "AddAccountPage", bundle: Bundle.main)
        guard let vcAddAccountPage = storyboard.instantiateViewController(withIdentifier: "AddAccountPageViewController") as? AddAccountPageViewController else { return }
        vcAddAccountPage.presenter.delegate = presenter
        navigationController?.pushViewController(vcAddAccountPage, animated: true)
        
    }
    
}

extension AccountsPageViewController: AccountsPageViewProtocol {
    
    func addNewElementAccounts(to indexPath: IndexPath) {
        tableViewAccounts.insertRows(at: [indexPath], with: .automatic)
    }

    func removeElementAccounts(to indexPath: IndexPath) {
        tableViewAccounts.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func labelAddCategoryAccountHiddenTrue() {
        labelPlaceholder.isHidden = true
    }
    
    func labelAddCategoryAccountHiddenFalse() {
        labelPlaceholder.isHidden = false
    }
    
    
    func reloadData() {
        tableViewAccounts.reloadData()
    }

}

extension AccountsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countElementsAccounts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewAccounts.dequeueReusableCell(withIdentifier: "TableCellAccounts", for: indexPath) as? TableCellAccounts else {
            return UITableViewCell() }
        let account = presenter.returnElementFromAccounts(for: indexPath)
//        let valueString = NSNumber(value: account.value).stringValue
        cell.update(name: account.nameAccount, value: String(account.value))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [
            UIContextualAction(
                style: .destructive,
                title: "Delete",
                handler: { _, _, _ in
                    self.presenter.removeAccountElement(for: indexPath)
                })
        ])
        return configuration
    }
    
}




