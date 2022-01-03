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
    func returnElementFromDate(for indexPath: IndexPath) -> Date
    
    func showAddEventPage()
    func addDedicateAccount(dedicatedAccount: Accounts)
    func addDedicateExpense(dedicatedExpense: Expenses)
    func addDedicateGain(dedicatedGain: Gains)
    func addDedicateDate(dedicatedDate: Date)
    func transmissionElement() -> AddNewEvent
    
    func updateGeneralExpense() -> String
    func updateGeneralGain() -> String
    func updateTotalBalance()
    
    
}

class MainPagePresenter: MainPagePresenterProtocol {

    weak var view: MainPageViewProtocol?
    
    private var gains: [Gains] = []
    private var expenses: [Expenses] = []
    private var accounts: [Accounts] = []
    private var date: [Date] = []
    
    
    private var eventInfo = AddNewEvent()

    func viewDidLoad() {
        view?.showProgressHud()
        view?.longPressButtonAccount()

        
    }
    
    func updateGeneralExpense() -> String {
        return String(expenses.sum(\.value))
    }
    
    func updateGeneralGain() -> String {
        return String(gains.sum(\.value))
    }
    
    func updateTotalBalance() {
        let totalBalance = String(self.accounts.sum(\.value))
        view?.updateTotalBalance(totalBalance: totalBalance)
    }
    
    func addDedicateAccount(dedicatedAccount: Accounts) {
        eventInfo.account = dedicatedAccount
    }
    
    func addDedicateExpense(dedicatedExpense: Expenses) {
        eventInfo.expense = dedicatedExpense
    }
    
    func addDedicateGain(dedicatedGain: Gains) {
        eventInfo.gain = dedicatedGain
    }
    
    func addDedicateDate(dedicatedDate: Date) {
        eventInfo.date = dedicatedDate
    }
    
    func reloadTableViewExpenseOrGain() {
        view?.tableReloadDataExpenseOrGain()
    }
    
    func transmissionElement() -> AddNewEvent {
        return eventInfo
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
    
    func returnElementFromDate(for indexPath: IndexPath) -> Date {
        return date[indexPath.row]
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
            self.view?.hideProgressHud()
                        
            self.view?.tableReloadDataAccounts()
            self.view?.tableReloadDataExpenseOrGain()
            self.view?.updateGeneralInfo(
                generalExpense: String(self.expenses.sum(\.value)),
                generalGain: String(self.gains.sum(\.value)),
                totalBalance: String(self.accounts.sum(\.value)))
            
        }
        
        
        
    }
    
    func showAddEventPage() {
        if eventInfo.account != nil && eventInfo.expense != nil && eventInfo.date != nil {
            view?.showAddEventPage()
            eventInfo.account = nil
            eventInfo.expense = nil
            eventInfo.date = nil
        } else if eventInfo.account != nil && eventInfo.gain != nil && eventInfo.date != nil {
            view?.showAddEventPage()
            eventInfo.account = nil
            eventInfo.gain = nil
            eventInfo.date = nil
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
  
}

struct AddNewEvent {
    var account: Accounts?
    var expense: Expenses?
    var gain: Gains?
    var date: Date?

    
}





