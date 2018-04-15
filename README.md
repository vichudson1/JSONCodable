# JSONCodable
### A protocol oriented programming approach to simplify the usual boiler plate when using the `Codable` protocol in Swift.
![Playground Image](PlaygroundScreenShot.png)

Start with a simple type that conforms to `Codable`.

``` swift
struct Post: Codable {
	let title: String?
	let content: String
}
```

Currently most of us are encoding and decoding to/from JSON like this.

``` swift
let aPost = Post(title: nil, content: "Some Really Interesting Commentary")

// encode as JSON Data
let coder = JSONEncoder()
let data = try? coder.encode(aPost)

// decode from JSON Data
let decoder = JSONDecoder()
let restoredPost = try? decoder.decode(Post.self, from: data!)
```


Now we can simply make our sample type above conform to our new protocol.

``` swift
extension Post: JSONCodable {}
```

Getting JSON Data for instances of our type and restoring them from it is much easier.

``` swift
// Get a JSON Data representation of an instance of our type.
let newData = aPost.jsonData()

// Restoring an instance of our type from JSON Data
let newRecoveredPost = Post(jsonData: newData)
```

Just add [JSONCodable.swift](https://github.com/vichudson1/JSONCodable/blob/master/JSONCodable/JSONCodable.swift) to your project and have your `Codable` types also conform to it. There is also a [Playground](https://github.com/vichudson1/JSONCodable/tree/master/JSONCodable.playground) in the repo with the working examples from above and I’ve blogged about this on [micro.blog](http://vichudson1.micro.blog/2018/04/15/easier-use-of.html) if you’d like to read more. 