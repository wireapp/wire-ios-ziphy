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
 * Represents an animated image provided by Giphy.
 */

public struct ZiphyAnimatedImage: Codable {

    public let type: ZiphyImageType
    public let url: URL
    public let width: Int
    public let height: Int
    public let fileSize: Int
    public let numberOfFrames: Int
    public let mp4VersionURL: URL
    public let mp4Size: Int
    public let webpVersionURL: URL
    public let webpSize: Int

    public var description: String {
        let values = [
            ("type = \(type.rawValue)"),
            ("url = \(url.absoluteString)"),
            ("width = \(width)"),
            ("height = \(height)"),
            ("fileSize = \(fileSize)"),
            ("numberOfFrames = \(numberOfFrames)"),
            ("mp4VersionURL = \(mp4VersionURL.absoluteString)"),
            ("mp4Size = \(mp4Size)"),
            ("webpVersionURL = \(webpVersionURL.absoluteString)"),
            ("webpSize = \(webpSize)")
        ]

        return "<< " + values.joined(separator: ", ") + ">>"
    }

    // MARK: - Initialization

    public init(type: ZiphyImageType, url: URL, width: Int, height: Int, fileSize: Int,
                numberOfFrames: Int, mp4: URL, mp4Size: Int, webp: URL, webpSize: Int) {

        self.type = type
        self.url = url
        self.width = width
        self.height = height

        self.fileSize = fileSize
        self.numberOfFrames = numberOfFrames
        self.mp4VersionURL = mp4
        self.mp4Size = mp4Size
        self.webpVersionURL = webp
        self.webpSize = webpSize

    }

    // MARK: - Codable

    public enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
        case width = "width"
        case height = "height"
        case fileSize = "size"
        case numberOfFrames = "frames"
        case mp4VersionURL = "mp4"
        case mp4Size = "mp4_size"
        case webpVersionURL = "webp"
        case webpSize = "webp_size"
    }
    
}
