//
//  RealmModel.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 11/03/2019.
//  Copyright © 2019 Artem Trubacheev. All rights reserved.
//

import RealmSwift
import RxDataSources

class Check: Object, IdentifiableType {    
    var identity: Int { return id }
    
    @objc dynamic var id = 0
    @objc dynamic var info: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var didYouMean: String = ""
    @objc dynamic var user: String = ""
    @objc dynamic var formatValid: Bool = true
    @objc dynamic var mxFound: Bool = false
    @objc dynamic var smtpCheck: Bool = false
    @objc dynamic var catchAll: Bool = false
    @objc dynamic var role: Bool = false
    @objc dynamic var disposable: Bool = false
    @objc dynamic var free: Bool = false
    @objc dynamic var score: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension CheckResult {
    func asRealm(with id: Int) -> Check {
        let check = Check()
        check.id = id
        
        check.info = info ?? ""
        check.email = email ?? ""
        check.didYouMean = didYouMean ?? ""
        check.user = user ?? ""
        check.formatValid = formatValid ?? false
        check.mxFound = mxFound ?? false
        check.smtpCheck = smtpCheck ?? false
        check.catchAll = catchAll ?? false
        check.role = role ?? false
        check.disposable = disposable ?? false
        check.free = free ?? false
        check.score = score ?? 0.5
        
        return check
    }
}

extension Results {
    func toCheckArray() -> [Check] {
        guard self.first is Check else { return [] }
        var array = [Check]()
        for i in 0 ..< count {
            let res = Check(value: self[i])
            array.append(res)
        }
        
        return array
    }
}
