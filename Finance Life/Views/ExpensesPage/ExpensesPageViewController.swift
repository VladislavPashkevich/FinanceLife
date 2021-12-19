//
//  ExpensesPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol ExpensesPageViewProtocol: AnyObject {
    func reloadCollectionView()
    func labelAddCategoryExpenseHiddenTrue()
    func labelAddCategoryExpenseHiddenFalse()
    func addNewExpense(to indexPath: IndexPath)
    func removeExpenseElement(to indexPath: IndexPath)
    
    
}

class ExpensesPageViewController: UIViewController {
    
    @IBOutlet private weak var expenseCollectionView: UICollectionView!
    @IBOutlet private weak var labelAddCategoryExpense: UILabel!
    
    var presenter: ExpensesPagePresenterProtocol = ExpensesPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        
        
        presenter.view = self
        presenter.viewDidLoad()
        
        expenseCollectionView.register(UINib(nibName: "CollectionCellExpense", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionCellExpense")
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction private func buttonAddExpense() {
        let alert = UIAlertController(title: "Создайте категорию расходов", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { textField in
            textField.placeholder = "Укажите категорию расхода"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            guard let self = self,
                    let expense = alert.textFields?.first?.text else {return}
            self.presenter.addNewExpense(expense: expense)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ExpensesPageViewController: ExpensesPageViewProtocol {
    
    func reloadCollectionView() {
        expenseCollectionView.reloadData()
    }
    
    func labelAddCategoryExpenseHiddenTrue() {
        labelAddCategoryExpense.isHidden = true
    }
    
    func labelAddCategoryExpenseHiddenFalse() {
        labelAddCategoryExpense.isHidden = false
    }
    
    func addNewExpense(to indexPath: IndexPath) {
        expenseCollectionView.performBatchUpdates({
            self.expenseCollectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
    
    func removeExpenseElement(to indexPath: IndexPath) {
        expenseCollectionView.performBatchUpdates({
            self.expenseCollectionView.deleteItems(at: [indexPath])
        }, completion: nil)
    }
    
    
    
}

extension ExpensesPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.countElementsExpenses()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellExpense", for: indexPath) as? CollectionCellExpense else {
            return UICollectionViewCell()
        }
        cell.update(text: presenter.returnElementFromExpenses(for: indexPath).nameExpense)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let expanses = presenter.returnArrayElementExpenses()[indexPath.item]
        
        let questionAlert = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .alert)
        questionAlert.addAction(UIAlertAction(title: "Изменить название?", style: .default, handler: { _ in
            let renameAlert = UIAlertController(title: "Введите новое название", message: nil, preferredStyle: .alert)
            renameAlert.addTextField(configurationHandler: nil)
            
            renameAlert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
            renameAlert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self = self,
                      let newNameExpense = renameAlert.textFields?.first?.text else {return}
                expanses.nameExpense = newNameExpense
                
                self.expenseCollectionView.reloadData() })
            
            self.present(renameAlert, animated: true, completion: nil)
            
        }))
        
        questionAlert.addAction(UIAlertAction(title: "Удалить категорию расходов?", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter.removeExpenseElement(for: indexPath)
            self.expenseCollectionView.reloadData()
            
        }))
        
        questionAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(questionAlert, animated: true, completion: nil)
    }
    
    
    
}




