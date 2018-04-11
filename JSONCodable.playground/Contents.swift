//: Playground - noun: a place where people can play

import Foundation

struct Post: Codable {
	let title: String?
	let content: String
}

let aPost = Post(title: nil, content: "Some Really Interesting Commentary")

////// The Way Most Of Us Currently Do This //////////////////////////////////
let coder = JSONEncoder()
let data = try? coder.encode(aPost)

let decoder = JSONDecoder()
let restoredPost = try? decoder.decode(Post.self, from: data!)

////////////// A New Protocol To Simplify This ///////////////////////////////
protocol JSONCodable { }

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

//////////////////// Now We can Do It Like This //////////////////////////////
extension Post: JSONCodable {}

let newData = aPost.jsonData()
let newRecoveredPost = Post(jsonData: newData)
print(newRecoveredPost?.content ?? "Blah")
