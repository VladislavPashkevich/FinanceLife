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
    func loadingCoreDataModels()
    func convertArrayToDictionaries()
    func countSections() -> Int
    func countRows(section: Int) -> Int
    func returnSectionsName(section: Int) -> String
    func returnDictionery(for indexPath: IndexPath) -> String
}

class StaticsPagePresenter: StaticsPagePresenterProtocol {
    
    
    private var expenses: [Expenses] = []
    private var gains: [Gains] = []
    
    private var generalDictionaryStruct: [TableObjects] = []
    

    weak var view: StaticsPageViewProtocol?

    func viewDidLoad() {

    }
    
    func convertArrayToDictionaries() {
        var arrayDictionaryExpenses: [[String : String]] = []
        var arrayDictionaryGains: [[String : String]] = []

        for date in expenses {
            let dictionary = [
                date.date.dateToString() : String(date.value)
            ]
            arrayDictionaryExpenses.append(dictionary)
        }
        for date in gains {
            let dictionary = [
                date.date.dateToString() : String(date.value)
            ]
            arrayDictionaryGains.append(dictionary)
        }
        
        let fullArray = arrayDictionaryGains + arrayDictionaryExpenses
        
        var resultDictionary = [String : [String]]()
        for dict in fullArray {
            for (key, value) in dict {
                resultDictionary[key, default: []].append(value)
            }
        }
        
        for (key, value) in resultDictionary {
            generalDictionaryStruct.append(TableObjects(sectionName: key, sectionObjects: value))
        }
        
        view?.tableViewReloadData()
                
    }
    
    
    
    
    func countSections() -> Int {
        return generalDictionaryStruct.count
    }
    
    func countRows(section: Int) -> Int {
        return generalDictionaryStruct[section].sectionObjects.count
    }
    
    func returnSectionsName(section: Int) -> String {
        return generalDictionaryStruct[section].sectionName
    }
    
    func returnDictionery(for indexPath: IndexPath) -> String {
        return generalDictionaryStruct[indexPath.section].sectionObjects[indexPath.row]
    }
    
    func loadingCoreDataModels() {
                
        let queue = DispatchQueue.global()
        queue.async {
            let gruop = DispatchGroup()
            
            gruop.enter()
            
            DatabaseService.shared.entitiesFor(
                type: Gains.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataGains in
                    guard let self =  self else { return }
                    self.gains = coreDataGains

                    gruop.leave()

                }
            )
            
            
            gruop.enter()
            
            DatabaseService.shared.entitiesFor(
                type: Expenses.self,
                context: DatabaseService.shared.persistentContainer.mainContext,
                closure: { [weak self] coreDataExpenses in
                    guard let self =  self else { return }
                    self.expenses = coreDataExpenses

                    gruop.leave()

                }
            )
   
            gruop.wait()
            
            self.convertArrayToDictionaries()
            
            self.view?.tableViewReloadData()
}
    }
}

struct TableObjects {
    var sectionName : String
    var sectionObjects : [String]
}
