//
//  AddEventPageViewController.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 19.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol AddEventPageViewProtocol: AnyObject {
    
    func returnValueTaxtField() -> String?
    
    func updateElementsOnView(element: AddNewEvent)

}

class AddEventPageViewController: UIViewController {
    
    @IBOutlet private weak var nameAccount: UILabel!
    @IBOutlet private weak var imageAccount: UIImageView!
    @IBOutlet private weak var nameExpenseOrGain: UILabel!
    @IBOutlet private weak var imageExpenseOrGain: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var valueTextField: UITextField!

    

	var presenter: AddEventPagePresenterProtocol = AddEventPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateElementOnView()
    }
    
    @IBAction private func addEvent() {
        presenter.resultToEvent(value: valueTextField.text)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func cancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func valueEventTextFieldDidChangeEditing() {
        let text = valueTextField.text
        presenter.valueTextFieldDidUpdateText(value: text)
    }
}

extension AddEventPageViewController: AddEventPageViewProtocol {
    
    func returnValueTaxtField() -> String? {
        let text = valueTextField.text
        return text
    }
    
    func updateElementsOnView(element: AddNewEvent) {
        nameAccount.text = element.account?.nameAccount
        imageAccount.image = UIImage(systemName: "creditcard.fill")
        dateLabel.text = element.date?.dateToString()
        if element.gain != nil {
            nameExpenseOrGain.text = element.gain?.nameGain
            imageExpenseOrGain.tintColor = .systemGreen
            imageExpenseOrGain.image = UIImage(systemName: "cart.fill.badge.plus")
        } else {
            nameExpenseOrGain.text = element.expense?.nameExpense
            imageExpenseOrGain.tintColor = .systemRed
            imageExpenseOrGain.image = UIImage(systemName: "cart.fill.badge.minus")
        }
    }
}

extension AddEventPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         return presenter.shouldChangeText(replacementString: string, shouldChangeCharactersIn: range)
    }
}


