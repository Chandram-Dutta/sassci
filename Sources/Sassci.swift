import ArgumentParser
import SwiftImage
import Rainbow

@main
struct Sassci: ParsableCommand {

	static let configuration = CommandConfiguration(
		commandName: "sassci",
		abstract: "A CLI utility to create ASCII art from images",
		version: "1.0.0"
	)

	@Argument(help: "The path to the image file to convert to ASCII art.")
	var imagePath: String

	@Option(help: "Scale to resize the image")
	var scale = 1.0

	@Option(help: "Each ASCII character is multiplied to make the image look less squashed")
	var charMultiplier = 3

	@Flag(help: "Inverts the brightness of the image")
	var invert = false
	
	@Flag(help: "Adds color to the picture")
	var color = true

	func run() throws {
		var image = Image<RGBA<UInt8>>(contentsOfFile: imagePath)!
		image = image.resizedTo(width: Int(Double(image.width) * scale), height: Int(Double(image.height) * scale))
		print("\(image.width), \(image.height)")
		var pixelCount = 0
		for pixel in image {
			if color {
				print(pixel.toBrightness().toASCII(charMultiplier: charMultiplier, invert: invert).bit24(pixel.red, pixel.green, pixel.blue), terminator: "")
			} else {
				print(pixel.toBrightness().toASCII(charMultiplier: charMultiplier, invert: invert), terminator: "")
			}
			
			pixelCount += 1

			if pixelCount % Int(image.width) == 0 {
				print()
			}
		}
	}
}

extension RGBA<UInt8> {
	func toBrightness() -> Int {
		return ((Int(self.red) + Int(self.green) + Int(self.blue)) / 3)
	}
}

extension Int {
	func toASCII(charMultiplier: Int, invert: Bool) -> String {
		var characters = "^\\\",:;Il!i~+_-?][}{1)(|/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$"
		if invert {
			characters = String(characters.reversed())
		}
		let characterCount = characters.count
		let index = self % characterCount
		return String(repeating: characters[characters.index(characters.startIndex, offsetBy: index)], count: charMultiplier)
	}
}
