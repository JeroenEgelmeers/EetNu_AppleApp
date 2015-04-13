//
//  Restaurant.swift
//  eindOpdrachtMBD2_hmwegelm
//
//  Created by User on 04/04/15.
//  Copyright (c) 2015 hmwegelm2060058. All rights reserved.
//

import Foundation

struct Restaurant {
    var rName: String
    var rRating: Int
    var rStreet: String
    var rPostcode: String
    var rPlace: String
    var rPhone: String
    var rLocLong: AnyObject
    var rLocLat: AnyObject
    
    init(name: String, rating: Int, street: String, postcode: String, place: String, phone: String, long: AnyObject, lat: AnyObject) {
        self.rName = name
        self.rRating = rating
        self.rStreet = street
        self.rPostcode = postcode
        self.rPlace = place
        self.rPhone = phone
        self.rLocLong = long
        self.rLocLat = lat
    }

}