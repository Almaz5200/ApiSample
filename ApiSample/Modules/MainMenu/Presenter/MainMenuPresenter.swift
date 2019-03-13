//
//  MainMenuPresenter.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

class MainMenuPresenter {
    weak var view: MainMenuViewInput?
    var interactor: MainMenuInteractorInput!
    var router: MainMenuRouterInput!
}

extension MainMenuPresenter: MainMenuViewOutput {
    func startCheckingTapped() {
        router.showChecking()
    }
    
    func savedTapped() {
        router.showSaved()
    }
}

extension MainMenuPresenter: MainMenuInteractorOutput {}
