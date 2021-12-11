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
    
    func addNewGain(gain: String)
    func removeGainElement(for indexPath: IndexPath)
    func countElementsGains() -> Int
    func returnElementFromGains(for indexPath: IndexPath) -> String
    
}

class GainsPagePresenter: GainsPagePresenterProtocol {

    weak var view: GainsPageViewProtocol?
    
    private var gains: [CategoryGain] = []

    func viewDidLoad() {
        
        DatabaseService.shared.entitiesFor(
            type: CategoryGain.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataGains in
                guard let self =  self else { return }
                self.gains = coreDataGains
                self.view?.reloadData()
                if coreDataGains.isEmpty {
                    self.view?.labelAddCategoryGainHiddenFalse()
                } else {
                    self.view?.labelAddCategoryGainHiddenTrue()
                }
            }
        )

    }
    
    func addNewGain(gain: String) {
        DatabaseService.shared.insertEntityFor(
            type: CategoryGain.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] coreDataGains in
                guard let self =  self else { return }
                coreDataGains.gain = gain
                
                DatabaseService.shared.saveMain({
                    self.gains.append(coreDataGains)
                    self.view?.addNewElementGains(to: IndexPath(
                        row: self.countElementsGains() - 1,
                        section: 0))
                    self.view?.labelAddCategoryGainHiddenTrue()
                    self.view?.reloadData()
                })
            })
    }
    
    func removeGainElement(for indexPath: IndexPath) {
        DatabaseService.shared.delete(
            gains[indexPath.row],
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] _ in
                guard let self = self else { return }
                DatabaseService.shared.saveMain({
                    self.gains.remove(at: indexPath.row)
                    self.view?.removeElementGains(to: indexPath)
                    if self.gains.count == 0 {
                        self.view?.labelAddCategoryGainHiddenFalse()
                    }
                })
            })
    }
    
    func countElementsGains() -> Int {
        return gains.count
    }
    
    func returnElementFromGains(for indexPath: IndexPath) -> String {
        return gains[indexPath.row].gain
    }
}
