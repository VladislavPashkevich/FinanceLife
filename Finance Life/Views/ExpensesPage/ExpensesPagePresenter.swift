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
    
    func addNewExpense(expense: String)
    func removeExpenseElement(for indexPath: IndexPath)
    func countElementsExpenses() -> Int
    func returnElementFromExpenses(for indexPath: IndexPath) -> String
    func returnArrayElementExpenses() -> [CategoryExpense]
    
}

class ExpensesPagePresenter: ExpensesPagePresenterProtocol {

    weak var view: ExpensesPageViewProtocol?
    
    private var expenses: [CategoryExpense] = []

    func viewDidLoad() {
        
        DatabaseService.shared.entitiesFor(
            type: CategoryExpense.self,
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
    
    
    func addNewExpense(expense: String) {
        DatabaseService.shared.insertEntityFor(
            type: CategoryExpense.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataExpenses in
                guard let self =  self else { return }
                coreDataExpenses.expense = expense
                
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
    func returnArrayElementExpenses() -> [CategoryExpense] {
        return expenses
    }
    
    func countElementsExpenses() -> Int {
        return expenses.count
    }
    
    func returnElementFromExpenses(for indexPath: IndexPath) -> String {
        return expenses[indexPath.item].expense 
    }
    
    
    
    
}
