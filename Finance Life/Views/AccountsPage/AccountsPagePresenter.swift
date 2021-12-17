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
    
    func removeAccountElement(for indexPath: IndexPath)
    func countElementsAccounts() -> Int
    func returnElementFromAccounts(for indexPath: IndexPath) -> Accounts
    func reloadData()
    
    
}


class AccountsPagePresenter: AccountsPagePresenterProtocol {
   
    weak var view: AccountsPageViewProtocol?
        
    private var accounts: [Accounts] = []

    func viewDidLoad() {
        
//        DatabaseService.shared.entitiesFor(
//            type: Accounts.self,
//            context: DatabaseService.shared.persistentContainer.mainContext,
//            closure: { [weak self] coreDataAccounts in
//                guard let self =  self else { return }
//                self.accounts = coreDataAccounts
//                self.view?.reloadData()
//                if coreDataAccounts.isEmpty {
//                    self.view?.labelAddCategoryAccountHiddenFalse()
//                } else {
//                    self.view?.labelAddCategoryAccountHiddenTrue()
//                }
//            }
//        )
        
        
        //когда вставляю загрузку из coredata виснет экран
    }
    
    
    func removeAccountElement(for indexPath: IndexPath) {
        DatabaseService.shared.delete(
            accounts[indexPath.row],
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataAccounts in
                guard let self = self else { return }
                DatabaseService.shared.saveMain({
                self.accounts.remove(at: indexPath.row)
                self.view?.removeElementAccounts(to: indexPath)
                if self.accounts.count == 0 {
                    self.view?.labelAddCategoryAccountHiddenFalse()
                }
            })
        })
        
    }
    
    func countElementsAccounts() -> Int {
        return accounts.count
    }
    
    func returnElementFromAccounts(for indexPath: IndexPath) -> Accounts {
        return accounts[indexPath.row]
    }
    
    func reloadData() {
        view?.reloadData()
    }
    
}

extension AccountsPagePresenter: UpdateAccounts {
    func updateAccounts(data: Accounts) {
        
        accounts.append(data)
        view?.reloadData()
        
    }
}





    
    


    
    
    





