//
//  SavedChecksContract.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Foundation
import RealmSwift

protocol SavedChecksViewInput: class {
    func showChecks(checks: [Check])
    func checkDeleted(check: Check)
    func disableInfiniteScrolling()
}
protocol SavedChecksViewOutput {
    func tableViewEndReached()
    func viewInited()
    func deleteActionFor(check: Check)
}

protocol SavedChecksInteractorInput {
    func getChecks(count: Int, offset: Int)
    func remove(check: Check)
}
protocol SavedChecksInteractorOutput: class {
    func fetchedChecks(checks: [Check])
    func didDeleted(check: Check)
    func checksEnded()
}

protocol SavedChecksRouterInput {}
