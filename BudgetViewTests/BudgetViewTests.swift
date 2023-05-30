//
//  BudgetViewTests.swift
//  BudgetViewTests
//
//  Created by Stef Castillo on 5/29/23.
//

import XCTest
@testable import BudgetView

final class BudgetViewTests: XCTestCase {
    
    var sut: WeeklySpendViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        sut = WeeklySpendViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
    }

    func test_weeklyBudget() {
        let income = sut?.calculateWeeklySpend(weeklyIncome: 100, taxes: 5, expenses: 5, deductions: 5, weeklySavings: 5, contributions: 5)
        XCTAssertEqual(income, 75)
    }

}
