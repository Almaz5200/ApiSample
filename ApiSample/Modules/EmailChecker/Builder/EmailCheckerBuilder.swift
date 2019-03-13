//
//  EmailCheckerBuilder.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Foundation
import UIKit

class EmailCheckerBuilder {

    static func build() -> EmailCheckerViewController {
	
		let viewController = UIStoryboard.init(name: "EmailChecker", bundle: nil).instantiateInitialViewController() as! EmailCheckerViewController
        
		let router = EmailCheckerRouter()

        let presenter = EmailCheckerPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = EmailCheckerInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        router.viewController = viewController
        
		return viewController
     }
	 
}
