//
//  AccountsPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol AccountsPagePresenterProtocol {
	var view: AccountsPageViewProtocol? { get set }
    func viewDidLoad()
}

class AccountsPagePresenter: AccountsPagePresenterProtocol {

    weak var view: AccountsPageViewProtocol?

    func viewDidLoad() {

    }
}
