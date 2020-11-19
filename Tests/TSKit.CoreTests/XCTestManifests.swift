import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ChainingTests.allTests),
        testCase(DataSizeTests.allTests),
        testCase(String_JSON_Tests.allTests)
    ]
}
#endif
