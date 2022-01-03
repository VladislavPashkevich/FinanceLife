//
//  MainPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 3.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import MBProgressHUD

// MARK: View -
protocol MainPageViewProtocol: AnyObject {
    func tableReloadDataExpenseOrGain()
    func tableReloadDataAccounts()
    func tableReloadDataDate()
    func showAddEventPage()
    func showProgressHud()
    func hideProgressHud()
    func updateTotalBalance(totalBalance: String)
    
    func updateGeneralInfo(generalExpense: String, generalGain: String, totalBalance: String)
    
    func longPressButtonAccount()
    
    
}

class MainPageViewController: UIViewController {
    
    @IBOutlet private weak var tableViewAccounts: UITableView!
    @IBOutlet private weak var tableViewDate: UITableView!
    @IBOutlet private weak var tableViewExpenseOrGain: UITableView!
    @IBOutlet private weak var buttonExpense: UIButton!
    @IBOutlet private weak var buttonGain: UIButton!
    @IBOutlet private weak var generalExpenseLabel: UILabel!
    @IBOutlet private weak var generalGainLabel: UILabel!
    @IBOutlet private weak var totalBalanceLabel: UILabel!
    @IBOutlet private weak var buttonAccount: UIButton!
    
    
    
    var presenter: MainPagePresenterProtocol = MainPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        
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
        presenter.updateTotalBalance()
        
        
        
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
    // MARK: Selector -
    @objc func longPressButtonAccount(_ guesture: UILongPressGestureRecognizer) {
        if guesture.state == UIGestureRecognizer.State.began {
                let storyboard = UIStoryboard(name: "AccountsPage", bundle: Bundle.main)
                guard let vcStatics = storyboard.instantiateViewController(withIdentifier: "AccountsPageViewController") as? AccountsPageViewController else { return }
                navigationController?.pushViewController(vcStatics, animated: true)  
            }
            
          }

    
}
// MARK: Extension -
extension MainPageViewController: MainPageViewProtocol {
    func longPressButtonAccount() {
        let longPressAccount = UILongPressGestureRecognizer(target: self, action: #selector(longPressButtonAccount(_:)))
        
        buttonAccount.addGestureRecognizer(longPressAccount)
    }
    
    func updateTotalBalance(totalBalance: String) {
        self.totalBalanceLabel.text = totalBalance
    }
    
    func showProgressHud() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideProgressHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func updateGeneralInfo(generalExpense: String, generalGain: String, totalBalance: String) {
        DispatchQueue.main.async {
            self.generalGainLabel.text = generalGain
            self.generalExpenseLabel.text = generalExpense
            self.totalBalanceLabel.text = totalBalance
        }
    }
    
    func tableReloadDataAccounts() {
        DispatchQueue.main.async {
            self.tableViewAccounts.reloadData()
        }
    }
    
    func tableReloadDataExpenseOrGain() {
        DispatchQueue.main.async {
            self.tableViewExpenseOrGain.reloadData()
        }
    }
    
    func tableReloadDataDate() {
        DispatchQueue.main.async {
            self.tableViewDate.reloadData()
        }
    }
    
    func showAddEventPage() {
        let storyboard = UIStoryboard(name: "AddEventPage", bundle: Bundle.main)
        guard let vcAddEventPage = storyboard.instantiateViewController(withIdentifier: "AddEventPageViewController") as? AddEventPageViewController else { return }
        vcAddEventPage.presenter.elementForEvent(element: presenter.transmissionElement())
        navigationController?.pushViewController(vcAddEventPage, animated: true)
    }
    
    
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch tableView {
        case tableViewAccounts:
            presenter.addDedicateAccount(dedicatedAccount: presenter.returnElementFromAccounts(for: indexPath))
            presenter.showAddEventPage()
        case tableViewExpenseOrGain:
            if buttonGain.isHidden == true {
                presenter.addDedicateExpense(dedicatedExpense: presenter.returnElementFromExpenses(for: indexPath))
                presenter.showAddEventPage()
            } else {
                presenter.addDedicateGain(dedicatedGain: presenter.returnElementFromGains(for: indexPath))
                presenter.showAddEventPage()
            }
        case tableViewDate:
            presenter.addDedicateDate(dedicatedDate: presenter.returnElementFromDate(for: indexPath))
            presenter.showAddEventPage()
        default:
            break
        }
        
    }
    
    
}






