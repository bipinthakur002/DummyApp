//
//  TestUtils.swift
//  DummyApp
//
//  Created by Bipin Thakur on 27/01/25.
//

import Foundation
import XCTest

public func loadMockData(from fileName: String, for testClass: AnyClass) -> Data {
    let bundle = Bundle(for: testClass)
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
        fatalError("Mock data file \(fileName).json not found in the bundle for \(testClass)")
    }
    return try! Data(contentsOf: url)
}
