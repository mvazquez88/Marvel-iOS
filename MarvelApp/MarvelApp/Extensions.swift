//
//  Extensions.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoString() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute, .second],
                                                       from: self, to: Date())

        if let year = interval.year, year > 0 {
            return "\(year) year\(year == 1 ? "" : "s") ago"
        } else if let month = interval.month, month > 0 {
            return "\(month) month\(month == 1 ? "" : "s") ago"
        } else if let week = interval.weekOfYear, week > 0 {
            return "\(week) week\(week == 1 ? "" : "s") ago"
        } else if let day = interval.day, day > 0 {
            return "\(day) day\(day == 1 ? "" : "s") ago"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour) hour\(hour == 1 ? "" : "s") ago"
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute) minute\(minute == 1 ? "" : "s") ago"
        } else if let second = interval.second, second > 1 {
            return "\(second) seconds ago"
        }
        return "1 second ago"
    }
}
