//
//  EmailCheckerPresenter.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

class EmailCheckerPresenter {
    weak var view: EmailCheckerViewInput?
    var interactor: EmailCheckerInteractorInput!
    var router: EmailCheckerRouterInput!
}

extension EmailCheckerPresenter: EmailCheckerViewOutput {
    func saveTappedWith(check: CheckResult) {
        if interactor.checkIfSaved(check: check) {
            interactor.deleteCheck(check: check)
        } else {
            interactor.save(check: check)
        }
    }
    
    func checkEmailTapperWith(email: String) {
        view?.setIndicator(animating: true)
        interactor.check(email: email)
    }
}

extension EmailCheckerPresenter: EmailCheckerInteractorOutput {
    func errorOccured(message: String) {
        view?.showError(with: message)
        view?.setIndicator(animating: false)
    }
    
    func fetchedCheck(emailCheck: CheckResult) {
        view?.setCheck(saved: interactor.checkIfSaved(check: emailCheck))
        view?.show(checkResult: emailCheck)
        view?.setIndicator(animating: false)
    }
    
    func didSavedOrDeleted(check: CheckResult) {
        view?.setCheck(saved: interactor.checkIfSaved(check: check))
    }
}
