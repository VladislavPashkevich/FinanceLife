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
}

class ExpensesPagePresenter: ExpensesPagePresenterProtocol {

    weak var view: ExpensesPageViewProtocol?

    func viewDidLoad() {

    }
}
