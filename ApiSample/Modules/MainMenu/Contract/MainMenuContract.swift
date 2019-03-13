//
//  MainMenuContract.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Foundation

protocol MainMenuViewInput: class {}
protocol MainMenuViewOutput {
    func startCheckingTapped()
    func savedTapped()
}

protocol MainMenuInteractorInput {}
protocol MainMenuInteractorOutput: class {}

protocol MainMenuRouterInput {
    func showChecking()
    func showSaved()
}
