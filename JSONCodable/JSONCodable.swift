//  JSONCodable.swift
//  Created by Victor Hudson on 4/11/18.
//  Copyright © 2018 Victor Hudson. All rights reserved.
//  Free to use under MIT License

import Foundation

protocol JSONCodable {}

extension JSONCodable where Self: Codable {
	static var encoder: JSONEncoder { return JSONEncoder() }
	static var decoder: JSONDecoder { return JSONDecoder() }
	
	func jsonData() -> Data? {
		return try? Self.encoder.encode(self)
	}
	
	init?(jsonData: Data?) {
		guard let data = jsonData,
			let anInstance = try? Self.decoder.decode(Self.self, from: data)
			else { return nil }
		self = anInstance
	}
}
