//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import XCTest
import ziphy

final class ZiphySearchResultsControllerTests: ZiphyTestCase {

    var sut: ZiphySearchResultsController!
    var ziphyClient: ZiphyClient!
    var mockZiphySearchResultsControllerDelegate: MockZiphySearchResultsControllerDelegate!

    override func setUp() {
        super.setUp()

        ZiphyClient.logLevel = ZiphyLogLevel.verbose
        self.ziphyClient = ZiphyClient(host:"api.giphy.com", requester:self.defaultRequester)

        sut = ZiphySearchResultsController(pageSize: 50, callbackQueue: DispatchQueue.main)
        sut.ziphyClient = ziphyClient

        mockZiphySearchResultsControllerDelegate = MockZiphySearchResultsControllerDelegate()
        sut.delegate = mockZiphySearchResultsControllerDelegate
    }

    override func tearDown() {
        sut = nil
        ziphyClient = nil
        mockZiphySearchResultsControllerDelegate = nil

        super.tearDown()
    }

    func testThatDelegateMethodIsCalledWhenTrending() {
        // GIVEN
        let expectation = self.expectation(description: "did return some results")

        // WHEN & THEN
        _ = sut.trending() { [weak self] (success, error) in
            XCTAssert(success)
            XCTAssert((self?.mockZiphySearchResultsControllerDelegate.resultsDidCleanedCalled)!)
            XCTAssertEqual(self?.mockZiphySearchResultsControllerDelegate.resultCount, 0)

            expectation.fulfill()
        }

        waitForExpectations(timeout: 20) { (error) in }
    }

    func testThatDelegateMethodIsCalledWhenSearch() {
        // GIVEN
        let expectation = self.expectation(description: "did return some results")

        // WHEN & THEN
        _ = sut.search(withSearchTerm: "apple") { [weak self] (success, error) in
            XCTAssert(success)
            XCTAssert((self?.mockZiphySearchResultsControllerDelegate.resultsDidCleanedCalled)!)
            XCTAssertEqual(self?.mockZiphySearchResultsControllerDelegate.resultCount, 0)
            XCTAssertGreaterThan((self?.sut.results.count)!, 0)

            expectation.fulfill()
        }

        waitForExpectations(timeout: 20) { (error) in }
    }
}

class MockZiphySearchResultsControllerDelegate: ZiphySearchResultsControllerDelegate {
    var resultsDidCleanedCalled = false
    var resultCount = -1

    func didCleanResults(ziphySearchResultsController: ZiphySearchResultsController) {
        resultsDidCleanedCalled = true
        resultCount = ziphySearchResultsController.results.count
    }
}
