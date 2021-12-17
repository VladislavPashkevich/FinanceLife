//
//  AddAccountPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 11.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol AddAccountPageViewProtocol: AnyObject {
    
    func returnTextValueAccountTextField() -> String?
    

}

class AddAccountPageViewController: UIViewController {
    
    @IBOutlet private weak var nameAccountTextField: UITextField!
    @IBOutlet private weak var valueAccountTextField: UITextField!

	var presenter: AddAccountPagePresenterProtocol = AddAccountPagePresenter()
    

    

	override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    @IBAction private func cancelButton() {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction private func createAccountButton() {
        let nameAccount = nameAccountTextField.text
        let value = valueAccountTextField.text
        presenter.createNewAccount(account: nameAccount, value: value)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func nameAccountTextFieldDidChangeEditing() {
        let text = nameAccountTextField.text
        presenter.nameAccountTextFieldDidUpdateText(name: text)
    }
    
    @IBAction private func valueAccountTextFieldDidChangeEditing() {
        let text = valueAccountTextField.text
        presenter.valueAccountTextFieldDidUpdateText(value: text)
    }
    
}

extension AddAccountPageViewController: AddAccountPageViewProtocol {
    func returnTextValueAccountTextField() -> String? {
        let text = valueAccountTextField.text
        return text
    }
}

extension AddAccountPageViewController: UITextFieldDelegate {
    
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    var rezult: Bool = true
    
    switch textField {
    case nameAccountTextField:
        return true
    case valueAccountTextField:
       rezult = presenter.shouldChangeText(replacementString: string, shouldChangeCharactersIn: range)
    default:
        break
    }
    return rezult
}
}


