//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by admin on 12/18/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL : URL
    let API_KEY = "c03ccc4dca2fd676a58b8cebc42b7565f474bb63"
    
    init(countryCode: String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
 
    }
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>)-> Void ) {
        print(resourceURL)
        let dataTask = URLSession.shared.dataTask(with: resourceURL ) {data, _, _ in
            guard let jasonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponse.self, from: jasonData)
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
        }
        dataTask.resume()
    }
    
}
