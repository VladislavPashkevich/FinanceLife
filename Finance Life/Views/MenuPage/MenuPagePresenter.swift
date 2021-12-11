//
//  MenuPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol MenuPagePresenterProtocol {
	var view: MenuPageViewProtocol? { get set }
    func viewDidLoad()
    
    func nameOnMenu(for indexPath: IndexPath) -> String
    func numberCellOnTableView() -> Int
    
    func switchSelectCell(for indexPath: IndexPath)

    
}

class MenuPagePresenter: MenuPagePresenterProtocol {

    weak var view: MenuPageViewProtocol?
    
    func viewDidLoad() {

    }
    
    func nameOnMenu(for indexPath: IndexPath) -> String {
        return menuBar.allCases[indexPath.row].rawValue
    }
    
    func numberCellOnTableView() -> Int {
        return menuBar.allCases.count
    }
    
    func switchSelectCell(for indexPath: IndexPath) {
        switch menuBar.allCases[indexPath.row] {
        case .Статистика:
            view?.showStatics()
        case .Счета:
            view?.showAccounts()
        case .Доходы:
            view?.showGain()
        case .Расходы:
            view?.showExpense()
        }
        
    }
    
}


enum menuBar: String, CaseIterable {
    case Статистика, Счета, Доходы, Расходы
}




