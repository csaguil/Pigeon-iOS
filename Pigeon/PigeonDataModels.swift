//
//  PigeonDataModels.swift
//  Pigeon
//
//  Created by Cristian Saguil on 7/5/17.
//  Copyright © 2017 Cristian Saguil. All rights reserved.
//

import Foundation
import RealmSwift

final class RideListing: Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var origin: String = ""
    dynamic var destination: String = ""
    dynamic var date: String = ""
    dynamic var time: String = ""
    dynamic var seats: Int = 0
}

final class RequestListing: Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var origin: String = ""
    dynamic var destination: String = ""
    dynamic var date: String = ""
    dynamic var time: String = ""
}

final class RideRequest: Object {
    dynamic var ride: RideListing? = nil
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
}

final class RequestAcceptance: Object {
    dynamic var request: RequestListing? = nil
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    
}
