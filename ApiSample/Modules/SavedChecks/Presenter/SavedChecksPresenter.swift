//
//  SavedChecksPresenter.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import RealmSwift

class SavedChecksPresenter {
    weak var view: SavedChecksViewInput?
    var interactor: SavedChecksInteractorInput!
    var router: SavedChecksRouterInput!
    
    let itemsPerPage = 3
    var offset = 0
}

extension SavedChecksPresenter: SavedChecksViewOutput {
    func tableViewEndReached() {
        interactor.getChecks(count: itemsPerPage, offset: offset)
    }
    
    func viewInited() {
        interactor.getChecks(count: itemsPerPage, offset: offset)
    }
    
    func deleteActionFor(check: Check) {
        interactor.remove(check: check)
    }
}

extension SavedChecksPresenter: SavedChecksInteractorOutput {
    func fetchedChecks(checks: [Check]) {
        offset += checks.count
        view?.showChecks(checks: checks)
    }
    
    func checksEnded() {
        view?.disableInfiniteScrolling()
    }
    
    func didDeleted(check: Check) {
        view?.checkDeleted(check: check)
    }
}
