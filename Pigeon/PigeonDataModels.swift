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
    dynamic var approved: Bool = false
    
    func copy2() -> RideListing {
        let copy = RideListing()
        copy.firstName = self.firstName
        copy.lastName = self.lastName
        copy.email = self.email
        copy.phone = self.phone
        copy.origin = self.origin
        copy.destination = self.destination
        copy.date = self.date
        copy.time = self.time
        copy .seats = self.seats
        copy.approved = self.approved
        return copy
    }
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
    dynamic var approved: Bool = false
    
    func copy2() -> RequestListing {
        let copy = RequestListing()
        copy.firstName = self.firstName
        copy.lastName = self.lastName
        copy.email = self.email
        copy.phone = self.phone
        copy.origin = self.origin
        copy.destination = self.destination
        copy.date = self.date
        copy.time = self.time
        copy.approved = self.approved
        return copy
    }
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

enum DataType {
    case RideListing
    case RequestListing
    case RideRequest
    case RequestAcceptance
}
