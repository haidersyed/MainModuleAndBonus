//
// Copyright © Essential Developer. All rights reserved.
//

import Foundation

public enum ImageCommentsEndpoint {
	case get(id: UUID)

	public func url(baseURL: URL) -> URL {
		switch self {
		case let .get(id):
			return baseURL.appendingPathComponent("/v1/image/\(id.uuidString)/comments")
		}
	}
}
