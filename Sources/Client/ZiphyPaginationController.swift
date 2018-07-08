//
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
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

import Foundation

/// A block that repeats a previous request, but moves to the given resource offset.
typealias ZiphyPaginatedFetchBlock = (_ offset: Int) -> CancelableTask?

/**
 * An object that handles pagination of Giphy requests.
 */

class ZiphyPaginationController {

    fileprivate(set) var ziphs: [Ziph] = []
    fileprivate (set) var totalPagesFetched = 0
    fileprivate var offset = 0

    /// Whether the end of the list was reached.
    fileprivate (set) var isAtEnd: Bool = false

    /// The block that fetches the paginated resource when needed.
    var fetchBlock: ZiphyPaginatedFetchBlock?

    /// The block that is called when the paginated data changes.
    var updateBlock: ZiphyListRequestCallback?

    // MARK: - Interacting with the Data

    /// Fetches a new page from the current offset.
    func fetchNewPage() -> CancelableTask? {
        return self.fetchNewPage(self.offset)
    }

    /// Removes all the paginated data from memory.
    func clearResults() {
        self.offset = 0
        self.ziphs = []
        self.totalPagesFetched = 0
    }

    // MARK: - Updating the Data

    fileprivate func fetchNewPage(_ offset:Int) -> CancelableTask? {
        guard !isAtEnd else {
            return nil
        }

        return self.fetchBlock?(offset)
    }
    
    func updatePagination(_ result: Result<[Ziph], ZiphyError>, filter: (Ziph) -> Bool) {

        switch result {
        case .success(let insertedZiphs):
            totalPagesFetched += 1
            ziphs.append(contentsOf: insertedZiphs.filter { filter($0) })
            offset = ziphs.count

        case .failure(let error):
            if case .noMorePages = error {
                isAtEnd = true
            }
        }

        self.updateBlock?(result)
    }

}
