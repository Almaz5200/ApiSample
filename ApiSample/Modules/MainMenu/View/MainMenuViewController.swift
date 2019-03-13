//
//  MainMenuViewController.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

fileprivate enum menuElementsList: String {
    case checkEmail = "Check E-Mail"
    case saved = "Saved E-Mail's"
}

class MainMenuViewController: BaseViewController {
    
    var output: MainMenuViewOutput!

    var rightBarButton: UIBarButtonItem?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        // Setup button to show saved E-Mails
        let savedButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        savedButton.rx.tap.subscribe { _ in
            self.output.savedTapped()
        }
        .disposed(by: disposeBag)
        self.rightBarButton = savedButton
        self.navigationItem.setRightBarButton(savedButton, animated: true)
    }
    
    @IBAction func StartCheckingTapped(_ sender: Any) {
        self.output.startCheckingTapped()
    }
}

extension MainMenuViewController: MainMenuViewInput {}
