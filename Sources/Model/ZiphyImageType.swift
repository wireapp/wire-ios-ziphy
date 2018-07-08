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

import Foundation

/**
 * The types of image provided by the Giphy API.
 *
 * When decoding this type from JSON, `unknown` will be used if the
 * name of the type is not in the list, instead of failing.
 */

public enum ZiphyImageType: String, Codable {

    case fixedHeight = "fixed_height"
    case fixedHeightStill = "fixed_height_still"
    case fixedHeightDownsampled = "fixed_height_downsampled"
    case fixedWidth = "fixed_width"
    case fixedWidthStill = "fixed_width_still"
    case fixedWidthDownsampled = "fixed_width_downsampled"
    case fixedHeightSmall = "fixed_height_small"
    case fixedHeightSmallStill = "fixed_height_small_still"
    case fixedWidthSmall = "fixed_width_small"
    case fixedWidthSmallStill = "fixed_width_small_still"
    case downsized = "downsized"
    case downsizedStill = "downsized_still"
    case downsizedLarge = "downsized_large"
    case original = "original"
    case originalStill = "original_still"
    case unknown

    // MARK: - Codable

    public init(from decoder: Decoder) throws {
        let nameString = try decoder.singleValueContainer().decode(String.self)
        self = ZiphyImageType(rawValue: nameString) ?? .unknown
    }

}
