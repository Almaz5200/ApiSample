//
//  MainMenuRouter.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import UIKit

class MainMenuRouter {
	var viewController: UIViewController!
}

extension MainMenuRouter: MainMenuRouterInput {
    func showChecking() {
        let vc = EmailCheckerBuilder.build()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSaved() {
        let vc = SavedChecksBuilder.build()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
