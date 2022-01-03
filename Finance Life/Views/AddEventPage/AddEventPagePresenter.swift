//
//  AddEventPagePresenter.swift
//  Finance Life
//
//  Created Vladislav Pashkevich on 19.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol AddEventPagePresenterProtocol {
	var view: AddEventPageViewProtocol? { get set }
    func viewDidLoad()
    func shouldChangeText(replacementString string: String, shouldChangeCharactersIn range: NSRange) -> Bool
    func valueTextFieldDidUpdateText(value: String?)
    
    func elementForEvent(element: AddNewEvent)
    
    func updateElementOnView()
    
    func resultToEvent(value: String?)

}

class AddEventPagePresenter: AddEventPagePresenterProtocol {
        
    private var valueDigit: Double?
    private var updateElement: AddNewEvent?
    private var dataForReport: [DataForReport] = []

    weak var view: AddEventPageViewProtocol?

    func viewDidLoad() {

    }
    
    func valueTextFieldDidUpdateText(value: String?) {
        guard let value = value?.toDouble() else {
            valueDigit = 0
            return
        }
        valueDigit = value
    }
    
    func shouldChangeText(replacementString string: String, shouldChangeCharactersIn range: NSRange) -> Bool {
        let text = view?.returnValueTaxtField() ?? ""
        let textTwo = NSString(string: text)
        let newText = textTwo.replacingCharacters(in: range, with: string)
           if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
               return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
           }
           return false
    }
    
    func elementForEvent(element: AddNewEvent) {
        updateElement = element
    }
    
    func updateElementOnView() {
        guard let updateElement = updateElement else {
            return
        }

        view?.updateElementsOnView(element: updateElement)
    }
    
    func resultToEvent(value: String?) {
        guard let value = value?.toDouble() else {
            return
        }
        if updateElement?.gain != nil {
            updateElement?.gain?.value += value
            updateElement?.account?.value += value
            DatabaseService.shared.saveMain(nil)
            
            DatabaseService.shared.insertEntityFor(
                type: DataForReport.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataForReport in
                    guard let self = self,
                          let date = self.updateElement?.date else { return }
                    coreDataForReport.boolValue = true
                    coreDataForReport.value = value
                    coreDataForReport.date = date
                    DatabaseService.shared.saveMain(nil)
                })
        } else {
            updateElement?.expense?.value += value
            updateElement?.account?.value -= value
            DatabaseService.shared.saveMain(nil)
            
            DatabaseService.shared.insertEntityFor(
                type: DataForReport.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataForReport in
                    guard let self = self,
                          let date = self.updateElement?.date else { return }
                    coreDataForReport.boolValue = false
                    coreDataForReport.value = value
                    coreDataForReport.date = date
                    DatabaseService.shared.saveMain(nil)
                })
        }
    }
}




