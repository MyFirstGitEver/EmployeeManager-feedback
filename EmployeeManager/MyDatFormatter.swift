//
//  MyDatFormatter.swift
//  EmployeeManager
//
//  Created by FVFH4069Q6L7 on 25/08/2023.
//

import Foundation

class MyDateFormatter {
    static func getDateDisplayFrom(date: Date) -> String {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .day, .month, .hour, .minute], from: date)
        
        return "\(twoDigit(components.day!))/\(twoDigit(components.month!))/ \(components.year!)"
    }
    
    static func twoDigit(_ number: Int) -> String {
        if number <= 9 {
            return "0\(number)"
        }
        
        return "\(number)"
    }
    
    static func getDateFromString(str: String) -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        
        return dateFormatterGet.date(from: str)
    }
}
