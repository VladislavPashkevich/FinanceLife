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
    func countSections() -> Int
    func countRows(section: Int) -> Int
    func returnSectionsName(section: Int) -> String
    func returnDictioneryStruct(for indexPath: IndexPath) -> [String : Bool]
}

class StaticsPagePresenter: StaticsPagePresenterProtocol {
    
    private var dataForReport: [DataForReport] = []
    
    private var generalDictionaryStruct: [TableObjects] = []
    

    weak var view: StaticsPageViewProtocol?

    func viewDidLoad() {

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
    
    func returnDictioneryStruct(for indexPath: IndexPath) -> [String : Bool] {
        return generalDictionaryStruct[indexPath.section].sectionObjects[indexPath.row]
    }
    
    func loadingCoreDataModels() {

        DatabaseService.shared.entitiesFor(
            type: DataForReport.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataForReport in
                guard let self = self else { return }
                
                self.dataForReport = coreDataForReport
                
                var arrayDictionaries = [[String : [String : Bool]]]()
                
                self.dataForReport.sort(by: { currentItem, previosItem in
                    currentItem.date > previosItem.date
                })
                let sortedDataPoints = self.dataForReport.sorted(by: { $0.date > $1.date })
                print(sortedDataPoints)
                for date in sortedDataPoints {
                    let dictionary = [
                        date.date.dateToString() : [String(date.value) : date.boolValue]
                    ]
                    arrayDictionaries.append(dictionary)
                }
                
                var resultDictionary = [String : [[String : Bool]]]()
           
                for dict in arrayDictionaries {
                    for (key, value) in dict {
                        resultDictionary[key, default: []].append(value)
                    }
                }
                
                
                for (key, value) in resultDictionary {
                    self.generalDictionaryStruct.append(TableObjects(sectionName: key, sectionObjects: value))
                }

                self.view?.tableViewReloadData()
                
            }
        )
    }
}

struct TableObjects {
    var sectionName : String
    var sectionObjects : [[String : Bool]]
}
    
