//
//  CheckResult.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 Artem Trubacheev. All rights reserved.
//

import ObjectMapper

class CheckResult: Mappable {
    
    var success: Bool?
    var info: String?
    var email: String?
    var didYouMean: String?
    var user: String?
    var formatValid: Bool?
    var mxFound: Bool?
    var smtpCheck: Bool?
    var catchAll: Bool?
    var role: Bool?
    var disposable: Bool?
    var free: Bool?
    var score: Double?
    
    init() {}
    
    init(check: Check) {
        self.info = check.info
        self.email = check.email
        self.didYouMean = check.didYouMean
        self.user = check.user
        self.formatValid = check.formatValid
        self.mxFound = check.mxFound
        self.smtpCheck = check.smtpCheck
        self.catchAll = check.catchAll
        self.role = check.role
        self.disposable = check.disposable
        self.free = check.free
        self.score = check.score
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        info <- map["info"]
        email <- map["email"]
        didYouMean <- map["did_you_mean"]
        user <- map["user"]
        formatValid <- map["format_valid"]
        mxFound <- map["mx_found"]
        smtpCheck <- map["smtp_check"]
        catchAll <- map["catch_all"]
        role <- map["role"]
        disposable <- map["disposable"]
        free <- map["free"]
        score <- map["score"]
    }
}
