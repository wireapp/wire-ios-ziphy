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

/**
 * An item representing a post from Giphy.
 */

public struct Ziph: Codable {

    public let identifier: String
    public let images: [ZiphyImageType: ZiphyAnimatedImage]
    public let title: String?

    public var description: String {
        return "identifier: \(self.identifier)\n" +
        "title: \(self.title ?? "nil")\n" +
        "images:\n\(self.images)\n"
    }

    // MARK: - Initialization

    public init(identifier: String, images: [ZiphyImageType: ZiphyAnimatedImage], title: String) {
        self.identifier = identifier
        self.images = images
        self.title = title
    }

}
