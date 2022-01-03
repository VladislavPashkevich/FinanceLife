//
//  StaticsPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol StaticsPageViewProtocol: AnyObject {
    
    func tableViewReloadData()

}

class StaticsPageViewController: UIViewController {
    
    @IBOutlet private var tableViewGruoped: UITableView!

	var presenter: StaticsPagePresenterProtocol = StaticsPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        


        presenter.view = self
        presenter.viewDidLoad()
        
        tableViewGruoped.register(UINib(nibName: "TableCellCtatics", bundle: Bundle.main), forCellReuseIdentifier: "TableCellCtatics")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadingCoreDataModels()
        


    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }
}

extension StaticsPageViewController: StaticsPageViewProtocol {
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.tableViewGruoped.reloadData()
        }
        
    }
}

extension StaticsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.countSections()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.returnSectionsName(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewGruoped.dequeueReusableCell(withIdentifier: "TableCellCtatics", for: indexPath) as? TableCellCtatics else {
            return UITableViewCell()
        }
        
        cell.update(selectCell: presenter.returnDictioneryStruct(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
