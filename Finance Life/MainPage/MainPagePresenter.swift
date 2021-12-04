//
//  MainPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 3.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol MainPagePresenterProtocol {
	var view: MainPageViewProtocol? { get set }
    func viewDidLoad()
}

class MainPagePresenter: MainPagePresenterProtocol {

    weak var view: MainPageViewProtocol?

    func viewDidLoad() {

    }
    
   
    
}


