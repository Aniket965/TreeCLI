import XCTest
@testable import TreeCLI

class TreeCLITests: XCTestCase {
    func testExample() {
        let cli = TreeCLI(filepaths: ["h.py"])
        XCTAssertEqual(cli.getTree(),"FileStructure\n├─h.py")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
