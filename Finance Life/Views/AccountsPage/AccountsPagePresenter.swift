//
//  AccountsPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol AccountsPagePresenterProtocol {
	var view: AccountsPageViewProtocol? { get set }
    func viewDidLoad()
    
    func addNewAccount(name: String, value: String)
    func removeAccountElement(for indexPath: IndexPath)
    func countElementsAccounts() -> Int
    func returnElementFromAccounts(for indexPath: IndexPath) -> Accounts
    
    
    
}

class AccountsPagePresenter: AccountsPagePresenterProtocol {
   
    weak var view: AccountsPageViewProtocol?
    
    private var accounts: [Accounts] = []

    func viewDidLoad() {

    }
    
    func addNewAccount(name: String, value: String) {
        
    }
    
    func removeAccountElement(for indexPath: IndexPath) {
        
    }
    
    func countElementsAccounts() -> Int {
        return accounts.count
    }
    
    func returnElementFromAccounts(for indexPath: IndexPath) -> Accounts {
        return accounts[indexPath.row]
    }
    
    
}
