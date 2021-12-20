//
//  ExpensesPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol ExpensesPagePresenterProtocol {
	var view: ExpensesPageViewProtocol? { get set }
    func viewDidLoad()
    func reloadCollectionViewData()
    func addNewExpense(expense: String)
    func removeExpenseElement(for indexPath: IndexPath)
    func countElementsExpenses() -> Int
    func returnElementFromExpenses(for indexPath: IndexPath) -> Expenses
    func returnArrayElementExpenses() -> [Expenses]
    
    
}

class ExpensesPagePresenter: ExpensesPagePresenterProtocol {

    weak var view: ExpensesPageViewProtocol?
    
    private var expenses: [Expenses] = []

    func viewDidLoad() {
        
        DatabaseService.shared.entitiesFor(
            type: Expenses.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataExpenses in
                guard let self =  self else { return }
                self.expenses = coreDataExpenses
                self.view?.reloadCollectionView()
                if coreDataExpenses.isEmpty {
                    self.view?.labelAddCategoryExpenseHiddenFalse()
                } else {
                    self.view?.labelAddCategoryExpenseHiddenTrue()
                }
            }
        )

    }
    
    func reloadCollectionViewData() {
        view?.reloadCollectionView()
    }
    
    
    func addNewExpense(expense: String) {
        DatabaseService.shared.insertEntityFor(
            type: Expenses.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataExpenses in
                guard let self =  self else { return }
                coreDataExpenses.nameExpense = expense
                coreDataExpenses.value = 0
                let date = Date()
                coreDataExpenses.date = date
                                
                DatabaseService.shared.saveMain({
                    self.expenses.append(coreDataExpenses)
                    self.view?.addNewExpense(to: IndexPath(
                        item: self.countElementsExpenses() - 1,
                        section: 0))
                    self.view?.labelAddCategoryExpenseHiddenTrue()
                    self.view?.reloadCollectionView()
                })
                
            }
        )
        
    }
    
    func removeExpenseElement(for indexPath: IndexPath) {
        DatabaseService.shared.delete(
            expenses[indexPath.item],
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] _ in
                guard let self = self else { return }
                DatabaseService.shared.saveMain({
                    self.expenses.remove(at: indexPath.item)
                    self.view?.removeExpenseElement(to: indexPath)
                    if self.expenses.count == 0 {
                        self.view?.labelAddCategoryExpenseHiddenFalse()
                    }
                })

            })
            }
    func returnArrayElementExpenses() -> [Expenses] {
        return expenses
    }
    
    func countElementsExpenses() -> Int {
        return expenses.count
    }
    
    func returnElementFromExpenses(for indexPath: IndexPath) -> Expenses {
        return expenses[indexPath.item]
    }
    
    
    
    
}
