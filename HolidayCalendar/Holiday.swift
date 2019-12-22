//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by admin on 12/18/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
    
}

struct DateInfo: Decodable{
    var iso : String
}
