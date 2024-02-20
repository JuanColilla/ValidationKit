# ValidationKit

![Swift 5.7](https://img.shields.io/badge/Swift-5.7-orange.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

ValidationKit is a lightweight Swift library for validating strings based on custom validation rules. It uses a property wrapper to make validation simple and easy to integrate into your projects. ValidationKit is compatible with Swift 5.7 and supports various validation types such as email, phone numbers, password, and more.

## Features

* Simple and easy-to-use API
* Customizable validation rules
* Built-in support for common validation scenarios
* Supports SwiftUI and Combine

## Installation

To use ValidationKit in your project, add it as a dependency to your Package.swift file:

<pre>
```swift
dependencies: [
    .package(url: "https://github.com/JuanColilla/ValidationKit.git", from: "1.0.0")
]
```
</pre>

Then, import ValidationKit in the files where you want to use it:

<pre>
```swift
import ValidationKit
```
</pre>

## Usage

Declare a property with the @Validated property wrapper and provide the desired validation rules:

<pre>
```swift
@Validated(.notEmpty)
var username: String
```
</pre>

Use the 'validationState' property to check the validation status of the value:

<pre>
```swift
if username.validationState == .valid {
    print("The username is valid.")
} else {
    print("The username is not valid.")
}
```
</pre>

Combine multiple validation rules for a single property:

<pre>
```swift
@Validated(.email, .notEmpty)
var email: String
```
</pre>

## Contributing

We welcome contributions, suggestions, and bug reports. Please open an issue on the GitHub repository to discuss your ideas or report any issues you encounter.

## License

ValidationKit is released under the MIT License. See the LICENSE file for more information.
