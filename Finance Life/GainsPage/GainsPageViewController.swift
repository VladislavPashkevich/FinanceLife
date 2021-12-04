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

}

class GainsPageViewController: UIViewController {

	var presenter: GainsPagePresenterProtocol = GainsPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false


        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }
}

extension GainsPageViewController: GainsPageViewProtocol {
    
}