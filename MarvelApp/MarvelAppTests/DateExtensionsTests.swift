//
//  DateExtensionsTests.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 05/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import XCTest
@testable import MarvelApp

class DateExtensionsTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTimeAgoExtension_returnsDescriptiveStringOfEllapsedTime() {
        let now = Date()
        let calendar = Calendar.current
        let cases = [(calendar.date(byAdding: .second, value: -10, to: now)!, "10 seconds ago"),
                     (calendar.date(byAdding: .minute, value: -5, to: now)!, "5 minutes ago"),
                     (calendar.date(byAdding: .hour, value: -2, to: now)!, "2 hours ago"),
                     (calendar.date(byAdding: .day, value: -3, to: now)!, "3 days ago"),
                     (calendar.date(byAdding: .weekOfYear, value: -3, to: now)!, "3 weeks ago"),
                     (calendar.date(byAdding: .month, value: -5, to: now)!, "5 months ago"),
                     (calendar.date(byAdding: .year, value: -30, to: now)!, "30 years ago")]
        
        cases.forEach {
            XCTAssertEqual($0.timeAgoString(), $1)
        }
    }
    
    func testTimeAgoExtension_IsAwareOfSingularUnitOfTime() {
        let now = Date()
        let calendar = Calendar.current
        let cases = [(calendar.date(byAdding: .second, value: -1, to: now)!, "1 second ago"),
                     (calendar.date(byAdding: .minute, value: -1, to: now)!, "1 minute ago"),
                     (calendar.date(byAdding: .hour, value: -1, to: now)!, "1 hour ago"),
                     (calendar.date(byAdding: .day, value: -1, to: now)!, "1 day ago"),
                     (calendar.date(byAdding: .weekOfYear, value: -1, to: now)!, "1 week ago"),
                     (calendar.date(byAdding: .month, value: -1, to: now)!, "1 month ago"),
                     (calendar.date(byAdding: .year, value: -1, to: now)!, "1 year ago")]
        
        cases.forEach {
            XCTAssertEqual($0.timeAgoString(), $1)
        }
    }

}
