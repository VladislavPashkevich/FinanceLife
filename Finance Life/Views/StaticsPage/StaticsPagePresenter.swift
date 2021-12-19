//
//  StaticsPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol StaticsPagePresenterProtocol {
	var view: StaticsPageViewProtocol? { get set }
    func viewDidLoad()
}

class StaticsPagePresenter: StaticsPagePresenterProtocol {

    weak var view: StaticsPageViewProtocol?

    func viewDidLoad() {

    }
}
