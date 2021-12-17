//
//  GainsPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol GainsPageViewProtocol: AnyObject {
    
    func reloadData()
    func addNewElementGains(to indexPath: IndexPath)
    func removeElementGains(to indexPath: IndexPath)
    func labelAddCategoryGainHiddenTrue()
    func labelAddCategoryGainHiddenFalse()

}

class GainsPageViewController: UIViewController {
    
    @IBOutlet private weak var tableViewGains: UITableView!
    @IBOutlet private weak var labelPlaceholder: UILabel!

	var presenter: GainsPagePresenterProtocol = GainsPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white


        presenter.view = self
        presenter.viewDidLoad()
        
        tableViewGains.register(UINib(nibName: "TableCellGain", bundle: Bundle.main), forCellReuseIdentifier: "TableCellGain")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction private func addCategoryGain() {
        let alert = UIAlertController(title: "Создайте категорию доходов", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { textField in
            textField.placeholder = "Укажите категорию дохода"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: UIAlertAction.Style.default, handler: { _ in
            guard let gain = alert.textFields?.first?.text else {return}
            self.presenter.addNewGain(gain: gain)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension GainsPageViewController: GainsPageViewProtocol {
    func addNewElementGains(to indexPath: IndexPath) {
        tableViewGains.insertRows(at: [indexPath], with: .automatic)
    }

    func removeElementGains(to indexPath: IndexPath) {
        tableViewGains.deleteRows(at: [indexPath], with: .automatic)

    }
    
    func labelAddCategoryGainHiddenTrue() {
        labelPlaceholder.isHidden = true
    }
    
    func labelAddCategoryGainHiddenFalse() {
        labelPlaceholder.isHidden = false
    }
    
    
    func reloadData() {
        tableViewGains.reloadData()
    }
    
}

extension GainsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countElementsGains()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewGains.dequeueReusableCell(withIdentifier: "TableCellGain", for: indexPath) as? TableCellGain else {
            return UITableViewCell()
        }
        cell.update(text: presenter.returnElementFromGains(for: indexPath).nameGain)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(actions: [
            UIContextualAction(
                style: .destructive,
                title: "Delete",
                handler: { _, _, _ in
                    self.presenter.removeGainElement(for: indexPath)
                })
        ])
        return configuration
    }
    
    
}
