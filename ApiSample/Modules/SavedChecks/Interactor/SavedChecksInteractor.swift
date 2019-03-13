//
//  SavedChecksInteractor.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import RealmSwift

class SavedChecksInteractor {
    weak var output: SavedChecksInteractorOutput?
    
    var realm = try! Realm()
    var checksList: Results<Check>
    
    init() {
        checksList = realm.objects(Check.self)
    }
}

extension SavedChecksInteractor: SavedChecksInteractorInput {
    func getChecks(count: Int, offset: Int) {
        let checks = checksList.toCheckArray()
        if offset >= checks.count {
            output?.checksEnded()
            return
        }
        output?.fetchedChecks(checks: Array(checks[offset..<min(count+offset, checks.count)]))
    }
    
    func remove(check: Check) {
        guard let realmCheck = checksList.first(where: { $0.email == check.email }) else {
            return
        }
        try! realm.write {
            realm.delete(realmCheck)
        }
        output?.didDeleted(check: check)
    }
}
