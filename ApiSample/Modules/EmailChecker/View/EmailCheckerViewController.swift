//
//  EmailChecker——ђђViewController.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import UIKit

class EmailCheckerViewController: BaseViewController {

    var output: EmailCheckerViewOutput!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var didYouMeanButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var isValid: SatusCircle!
    @IBOutlet weak var isSmtp: SatusCircle!
    @IBOutlet weak var isInMx: SatusCircle!
    @IBOutlet weak var isCatchAll: SatusCircle!
    @IBOutlet weak var isRole: SatusCircle!
    @IBOutlet weak var isDisposable: SatusCircle!
    @IBOutlet weak var isFree: SatusCircle!
    
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentCheck: CheckResult? {
        didSet {
            placeHolderView.isHidden = !(currentCheck == nil)
            if let didYouMean = currentCheck?.didYouMean, didYouMean != "" {
                didYouMeanButton.setTitle(didYouMean, for: .normal)
                didYouMeanButton.isEnabled = true
            } else {
                didYouMeanButton.setTitle("No suggestions", for: .normal)
                didYouMeanButton.isEnabled = false
            }
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initRightBarButton()
        initBackgroundTapDismiss()
        self.currentCheck = nil
    }
    
    func initBackgroundTapDismiss() {
        let tap = UITapGestureRecognizer()
        
        tap.rx.event.subscribe { _ in
            self.view.endEditing(true)
        }
        .addDisposableTo(disposeBag)
        
        backgroundView.addGestureRecognizer(tap)
    }
    
    func initRightBarButton() {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "star_empty"), style: .plain, target: nil, action: nil)
        
        button.isEnabled = false
        button.rx.tap.subscribe { _ in
            guard let check = self.currentCheck else { return }
            
            self.output.saveTappedWith(check: check)
        }
        .disposed(by: disposeBag)
        
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    @IBAction func didYouMeanTapped(_ sender: Any) {
        guard let email = self.currentCheck?.didYouMean, email != "" else { return }
        
        self.emailField.text = email
        output.checkEmailTapperWith(email: email)
    }
    
    @IBAction func checkTapped(_ sender: Any) {
        self.view.endEditing(true)
        output.checkEmailTapperWith(email: emailField.text ?? "")
    }
}

extension EmailCheckerViewController: EmailCheckerViewInput {
    func setIndicator(animating: Bool) {
        self.view.isUserInteractionEnabled = !animating
        if animating {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func setCheck(saved: Bool) {
        self.navigationItem.rightBarButtonItem?.image = saved ? #imageLiteral(resourceName: "star_filled") : #imageLiteral(resourceName: "star_empty")
    }
    
    func show(checkResult: CheckResult) {
        self.currentCheck = checkResult
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        guard checkResult.success != false else {
            let errorAlert = UIAlertController(title: "Error",
                                               message: checkResult.info ?? "Something went wrong",
                                               preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.show(errorAlert, sender: self)
            return
        }
        
        if let score = checkResult.score {
            self.scoreLabel.isHidden = false
            switch score {
            case 0..<0.45:
                self.scoreLabel.textColor = scoreColors.bad
            case 0.45..<0.8:
                self.scoreLabel.textColor = scoreColors.middle
            case 0.8...1:
                self.scoreLabel.textColor = scoreColors.good
            default:
                self.scoreLabel.textColor = scoreColors.middle
            }
            self.scoreLabel.text = score.description
        } else {
            self.scoreLabel.isHidden = true
        }
        
        isValid.isOn = checkResult.formatValid ?? false
        isSmtp.isOn = checkResult.smtpCheck ?? false
        isInMx.isOn = checkResult.mxFound ?? false
        isCatchAll.isOn = checkResult.catchAll ?? false
        isRole.isOn = checkResult.role ?? false
        isDisposable.isOn = checkResult.disposable ?? false
        isFree.isOn = checkResult.free ?? false
    }
}
