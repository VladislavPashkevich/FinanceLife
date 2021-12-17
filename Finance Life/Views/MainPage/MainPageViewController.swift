//
//  MainPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 3.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol MainPageViewProtocol: AnyObject {
    func tableReloadDataExpenseOrGain()
    func tableReloadDataAccounts()
    func tableReloadDataDate()
    
}

class MainPageViewController: UIViewController {
    
    @IBOutlet private weak var tableViewAccounts: UITableView!
    @IBOutlet private weak var tableViewDate: UITableView!
    @IBOutlet private weak var tableViewExpenseOrGain: UITableView!
    @IBOutlet private weak var buttonExpense: UIButton!
    @IBOutlet private weak var buttonGain: UIButton!
    
    
    var presenter: MainPagePresenterProtocol = MainPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        presenter.view = self
        presenter.viewDidLoad()
        
        
        tableViewAccounts.register(UINib(nibName: "MyCellView", bundle: Bundle.main), forCellReuseIdentifier: "MyCellView")
        
        tableViewExpenseOrGain.register(UINib(nibName: "MyCellExpence", bundle: Bundle.main), forCellReuseIdentifier: "MyCellExpence")
        
        tableViewExpenseOrGain.register(UINib(nibName: "MyCellGain", bundle: Bundle.main), forCellReuseIdentifier: "MyCellGain")
        
        tableViewDate.register(UINib(nibName: "MyCellDate", bundle: Bundle.main), forCellReuseIdentifier: "MyCellDate")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                presenter.loadingCoreDataModels()

        presenter.calendarDate()
        presenter.reloadTableViewAccounts()
        presenter.reloadTableViewExpenseOrGain()
        
        
    }
    
    @IBAction private func pressButtonExpence() {
        buttonExpense.isHidden = true
        buttonGain.isHidden = false
        presenter.reloadTableViewExpenseOrGain()
        
    }
    
    @IBAction private func pressButtonGain() {
        buttonGain.isHidden = true
        buttonExpense.isHidden = false
        presenter.reloadTableViewExpenseOrGain()
    }
    
    @IBAction private func openMenuButton() {
        let storyboard = UIStoryboard(name: "MenuPage", bundle: Bundle.main)
        guard let vcMenu = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as? MenuPageViewController else { return }
        navigationController?.pushViewController(vcMenu, animated: true)
    }
    
}
// MARK: Extension -
extension MainPageViewController: MainPageViewProtocol {
    func tableReloadDataAccounts() {
        tableViewAccounts.reloadData()
    }
    
    func tableReloadDataExpenseOrGain() {
        tableViewExpenseOrGain.reloadData()
    }
    
    func tableReloadDataDate() {
        tableViewDate.reloadData()
    }
    
    
    
    // либо через enum сделат смену доход расходов
    
}


extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tableViewAccounts:
            return presenter.countElementsAccounts()
        case tableViewExpenseOrGain:
            if buttonGain.isHidden == true {
                return presenter.countElementsExpenses()
            } else {
                return presenter.countElementsGains()
            }
        case tableViewDate:
            return presenter.countElementsDate()
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case tableViewAccounts:
            guard let cell = tableViewAccounts.dequeueReusableCell(withIdentifier: "MyCellView", for: indexPath) as? MyCellView else {
                return UITableViewCell()
            }
            cell.update(text: presenter.returnElementFromAccounts(for: indexPath).nameAccount, value: presenter.returnElementFromAccounts(for: indexPath).value)
            return cell
        case tableViewExpenseOrGain:
            if buttonGain.isHidden == true {
                guard let cell = tableViewExpenseOrGain.dequeueReusableCell(withIdentifier: "MyCellExpence", for: indexPath) as? MyCellExpence else {
                    return UITableViewCell()
                }
                cell.update(text: presenter.returnElementFromExpenses(for: indexPath).nameExpense, value: presenter.returnElementFromExpenses(for: indexPath).value)
                return cell
            } else {
                
                guard let cell = tableViewExpenseOrGain.dequeueReusableCell(withIdentifier: "MyCellGain", for: indexPath) as? MyCellGain else {
                    return UITableViewCell()
                }
                cell.update(text: presenter.returnElementFromGains(for: indexPath).nameGain, value: presenter.returnElementFromGains(for: indexPath).value)
                return cell
            }
            
        case tableViewDate:
            guard let cell = tableViewDate.dequeueReusableCell(withIdentifier: "MyCellDate", for: indexPath) as? MyCellDate else {
                return UITableViewCell()
            }
            cell.update(date: presenter.returnElementFromDate(for: indexPath))
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
        
    }
}



