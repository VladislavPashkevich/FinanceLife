//
//  MainPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 3.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol MainPagePresenterProtocol {
	var view: MainPageViewProtocol? { get set }
    func viewDidLoad()
    func reloadTableViewExpenseOrGain()
    func reloadTableViewAccounts()
    
    func countElementsGains() -> Int
    func returnElementFromGains(for indexPath: IndexPath) -> Gains
    
    func countElementsExpenses() -> Int
    func returnElementFromExpenses(for indexPath: IndexPath) -> Expenses
    
    func countElementsAccounts() -> Int
    func returnElementFromAccounts(for indexPath: IndexPath) -> Accounts
    
    func loadingCoreDataModels()
    func calendarDate()
    
    func countElementsDate() -> Int
    func returnElementFromDate(for indexPath: IndexPath) -> String
    
}

class MainPagePresenter: MainPagePresenterProtocol {
    

    weak var view: MainPageViewProtocol?
    
    private var gains: [Gains] = []
    private var expenses: [Expenses] = []
    private var accounts: [Accounts] = []
    private var date: [Date] = []
    

    func viewDidLoad() {
        
       
        
    

    }
    
    func reloadTableViewExpenseOrGain() {
        view?.tableReloadDataExpenseOrGain()
    }
    

    
    func reloadTableViewAccounts() {
        view?.tableReloadDataAccounts()
    }
    
    func countElementsGains() -> Int {
        return self.gains.count
    }
    
    func returnElementFromGains(for indexPath: IndexPath) -> Gains {
        return self.gains[indexPath.row]
    }
    
    func countElementsExpenses() -> Int {
        return self.expenses.count

    }
    
    func returnElementFromExpenses(for indexPath: IndexPath) -> Expenses {
        return self.expenses[indexPath.row]

    }
    
    func countElementsAccounts() -> Int {
        return self.accounts.count

    }
    
    func returnElementFromAccounts(for indexPath: IndexPath) -> Accounts {
        return self.accounts[indexPath.row]

    }
    
    func countElementsDate() -> Int {
        return date.count
    }
    
    func returnElementFromDate(for indexPath: IndexPath) -> String {
        return date[indexPath.row].dateToString()
    }
    
    func calendarDate() {
        let dateNow = Date()
        let dateYesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateDayBeforeYesterday = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        guard let dateYesterday = dateYesterday,
              let dateDayBeforeYesterday = dateDayBeforeYesterday else {
            return
        }
        date.removeAll()
        date.append(dateNow)
        date.append(dateYesterday)
        date.append(dateDayBeforeYesterday)
        view?.tableReloadDataDate()
    }
    
    func loadingCoreDataModels() {
                
        let queue = DispatchQueue.global()
        queue.async {
            let gruop = DispatchGroup()
            
            gruop.enter()
            
            DatabaseService.shared.entitiesFor(
                type: Gains.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataGains in
                    guard let self =  self else { return }
                    self.gains = coreDataGains

                    gruop.leave()

                }
            )
            
            
            gruop.enter()
            
            DatabaseService.shared.entitiesFor(
                type: Expenses.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataExpenses in
                    guard let self =  self else { return }
                    self.expenses = coreDataExpenses

                    gruop.leave()

                }
            )
            
            gruop.enter()
            DatabaseService.shared.entitiesFor(
                type: Accounts.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataAccounts in
                    guard let self = self else { return }
                    self.accounts = coreDataAccounts

                    gruop.leave()
                })
            
            
            gruop.wait()
            
            print(self.gains, self.expenses, self.accounts)

            
            self.view?.tableReloadDataAccounts()
            self.view?.tableReloadDataExpenseOrGain()
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
  
}





