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

}

class MainPageViewController: UIViewController {
    
    @IBOutlet private weak var tableViewAccounts: UITableView!
    @IBOutlet private weak var tableViewDate: UITableView!
    @IBOutlet private weak var tableViewExpenseOrGain: UITableView!
    @IBOutlet private weak var buttonExpense: UIButton!
    @IBOutlet private weak var buttonGain: UIButton!
    
    
    
    let arrayText: [String] = ["Bank", "Nalik"]
    let arrayValue: [Int] = [100, 95]
    
    var presenter: MainPagePresenterProtocol = MainPagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        presenter.view = self
        presenter.viewDidLoad()
        
        tableViewAccounts.register(UINib(nibName: "MyCellView", bundle: Bundle.main), forCellReuseIdentifier: "MyCellView")
        tableViewAccounts.register(UINib(nibName: "MyCellExpence", bundle: Bundle.main), forCellReuseIdentifier: "MyCellExpence")
        tableViewAccounts.register(UINib(nibName: "MyCellGain", bundle: Bundle.main), forCellReuseIdentifier: "MyCellGain")
        tableViewAccounts.register(UINib(nibName: "MyCellDate", bundle: Bundle.main), forCellReuseIdentifier: "MyCellDate")
        
    }
    
    func categoryName(for indexPath: IndexPath) -> String {
        return arrayText[indexPath.row]
        
    }
    
    func categoryValue(for indexPath: IndexPath) -> Int {
        return arrayValue[indexPath.row]
        
    }
    
    @IBAction private func pressButtonExpence() {
        buttonExpense.isHidden = true
        buttonGain.isHidden = false
        tableViewExpenseOrGain.reloadData()

    }
    
    @IBAction private func pressButtonGain() {
        buttonGain.isHidden = true
        buttonExpense.isHidden = false
        tableViewExpenseOrGain.reloadData()
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

    
    
    
    
    
    
    
    
}


extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case tableViewAccounts:
            guard let cell = tableViewAccounts.dequeueReusableCell(withIdentifier: "MyCellView", for: indexPath) as? MyCellView else {
                return UITableViewCell()
            }
            cell.update(text: categoryName(for: indexPath), value: categoryValue(for: indexPath))
            return cell
        case tableViewExpenseOrGain:
            if buttonGain.isHidden == true {
            guard let cell = tableViewAccounts.dequeueReusableCell(withIdentifier: "MyCellExpence", for: indexPath) as? MyCellExpence else {
                return UITableViewCell()
            }
            cell.update(text: categoryName(for: indexPath), value: categoryValue(for: indexPath))
            return cell
            } else {
                guard let cell = tableViewAccounts.dequeueReusableCell(withIdentifier: "MyCellGain", for: indexPath) as? MyCellGain else {
                    return UITableViewCell()
                }
                cell.update(text: categoryName(for: indexPath), value: categoryValue(for: indexPath))
                return cell
            }
        case tableViewDate:
            guard let cell = tableViewAccounts.dequeueReusableCell(withIdentifier: "MyCellDate", for: indexPath) as? MyCellDate else {
                return UITableViewCell()
            }
            cell.update(date: "03 сент", day: "Сегодня")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    
    
    
}
