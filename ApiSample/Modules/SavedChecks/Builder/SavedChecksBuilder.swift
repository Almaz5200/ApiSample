//
//  SavedChecksBuilder.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Foundation
import UIKit

class SavedChecksBuilder {

    static func build() -> SavedChecksViewController {
	
		let viewController = UIStoryboard(name: "SavedChecks", bundle: nil).instantiateInitialViewController() as! SavedChecksViewController
        
		let router = SavedChecksRouter()

        let presenter = SavedChecksPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SavedChecksInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        router.viewController = viewController
        
		return viewController
     }
	 
}
