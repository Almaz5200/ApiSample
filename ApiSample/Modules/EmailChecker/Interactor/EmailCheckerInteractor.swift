//
//  EmailCheckerInteractor.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 atrubacheev. All rights reserved.
//

import Moya
import ObjectMapper
import RxSwift
import Moya_ObjectMapper
import RealmSwift

class EmailCheckerInteractor {
    var provider = MoyaProvider<APIManager>()
    var disposeBag = DisposeBag()
    var realm = try! Realm()
    var checksList: Results<Check>
    
    weak var output: EmailCheckerInteractorOutput?
    
    init() {
        checksList = realm.objects(Check.self)
    }
}

extension EmailCheckerInteractor: EmailCheckerInteractorInput {
    func save(check: CheckResult) {
        let realmCheck = check.asRealm(with: (checksList.last?.id ?? -1) + 1)
        try! realm.write {
            realm.add(realmCheck)
        }
        output?.didSavedOrDeleted(check: check)
    }
    
    func deleteCheck(check: CheckResult) {
        guard let realmCheck = checksList.first(where: { $0.email == check.email }) else {
            self.output?.errorOccured(message: "Couldn't find check")
            return
        }
        try! realm.write {
            realm.delete(realmCheck)
        }
        output?.didSavedOrDeleted(check: check)
    }
    
    func checkIfSaved(check: CheckResult) -> Bool {
        return checksList.first(where: { $0.email == check.email }) != nil
    }
    
    func check(email: String) {
        if let check = checksList.first(where: { $0.email == email }) {
            self.output?.fetchedCheck(emailCheck: CheckResult(check: check))
            return
        }
        
        provider.rx.request(.checkEmail(email: email))
            .mapObject(CheckResult.self)
            .subscribe(onSuccess: { (response) in
                self.output?.fetchedCheck(emailCheck: response)
            }) { (error) in
                self.output?.errorOccured(message: error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
