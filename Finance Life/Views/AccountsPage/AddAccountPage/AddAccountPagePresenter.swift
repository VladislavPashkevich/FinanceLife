//
//  AddAccountPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 11.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: Presenter -
protocol AddAccountPagePresenterProtocol {
    var view: AddAccountPageViewProtocol? { get set }
    
    var delegate: UpdateAccountsDelegateProtocol? { get set }
    func viewDidLoad()
    
    func createNewAccount(account: String?, value: String?)
    func nameAccountTextFieldDidUpdateText(name: String?)
    func valueAccountTextFieldDidUpdateText(value: String?)
    func shouldChangeText(replacementString string: String, shouldChangeCharactersIn range: NSRange) -> Bool
    
    
    
}

class AddAccountPagePresenter: AddAccountPagePresenterProtocol {
    var delegate: UpdateAccountsDelegateProtocol?
    
    
    weak var view: AddAccountPageViewProtocol?
    
    private var nameDigit: String?
    private var valueDigit: Double?

    
    func viewDidLoad() {
        
    }
    
  
    
    func createNewAccount(account: String?, value: String?) {
        DatabaseService.shared.insertEntityFor(
            type: Accounts.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { coreDataAccounts in
                guard let account = account,
                      let value = value
                else { return }
                coreDataAccounts.nameAccount = account
                coreDataAccounts.value = value.toDouble() ?? 0
                
                self.delegate?.updateAccounts(data: coreDataAccounts)
                
                DatabaseService.shared.saveMain(nil)
            })
    }
    
    func nameAccountTextFieldDidUpdateText(name: String?) {
        guard let name = name else {
            nameDigit = nil
            return
        }
        nameDigit = name
    }
    
    func valueAccountTextFieldDidUpdateText(value: String?) {
        guard let value = value?.toDouble() else {
            valueDigit = 0
            return
        }
        valueDigit = value
    }
    
    
    func shouldChangeText(replacementString string: String, shouldChangeCharactersIn range: NSRange) -> Bool {
        
        let text = view?.returnTextValueAccountTextField() ?? ""
        let textTwo = NSString(string: text)
        let newText = textTwo.replacingCharacters(in: range, with: string)
           if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
               return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
           }
           return false
    }
}

// через презентер делегирование делать
protocol UpdateAccountsDelegateProtocol {
    func updateAccounts(data: Accounts)
}




