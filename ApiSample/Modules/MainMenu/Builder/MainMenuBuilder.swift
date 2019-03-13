//
//  MainMenuBuilder.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Foundation
import UIKit

class MainMenuBuilder {

    static func build() -> MainMenuViewController {
	
		let viewController = UIStoryboard.init(name: "MainMenu", bundle: nil).instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        
		let router = MainMenuRouter()

        let presenter = MainMenuPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = MainMenuInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        router.viewController = viewController
        
		return viewController
     }
	 
}
