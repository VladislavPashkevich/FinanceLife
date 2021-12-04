//
//  GainsPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol GainsPagePresenterProtocol {
	var view: GainsPageViewProtocol? { get set }
    func viewDidLoad()
}

class GainsPagePresenter: GainsPagePresenterProtocol {

    weak var view: GainsPageViewProtocol?

    func viewDidLoad() {

    }
}
