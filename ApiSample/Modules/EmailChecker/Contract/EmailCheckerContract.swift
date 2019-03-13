//
//  EmailCheckerContract.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Foundation

protocol EmailCheckerViewInput: class {
    func show(checkResult: CheckResult)
    func setIndicator(animating: Bool)
    func showError(with message: String)
    func setCheck(saved: Bool)
}
protocol EmailCheckerViewOutput {
    func checkEmailTapperWith(email: String)
    func saveTappedWith(check: CheckResult)
}

protocol EmailCheckerInteractorInput {
    func check(email: String)
    func save(check: CheckResult)
    func deleteCheck(check: CheckResult)
    func checkIfSaved(check: CheckResult) -> Bool
}
protocol EmailCheckerInteractorOutput: class {
    func fetchedCheck(emailCheck: CheckResult)
    func errorOccured(message: String)
    func didSavedOrDeleted(check: CheckResult)
}

protocol EmailCheckerRouterInput {}
