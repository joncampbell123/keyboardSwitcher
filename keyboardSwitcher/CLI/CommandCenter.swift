//
//  CommandCenter.swift
//  keyboardSwitcher
//
//  Created by Wolfgang Lutz on 07.10.16.
//  Copyright © 2016 number42. All rights reserved.
//

class CommandCenter {
	func printLayout() {
		print(WLKeyboardManager.shared().currentKeyboardLayout().localizedName)
	}

	func listLayouts() {
		print("Available Layouts:")
		self.printLayouts(layouts: WLKeyboardManager.shared().keyboardLayouts())
	}

	func listEnabled() {
		print("Enabled Layouts:")
		self.printLayouts(layouts: WLKeyboardManager.shared().enabledLayouts())
	}

	internal func printLayouts(layouts: [WLKeyboardSource]) {
		layouts.flatMap { $0.localizedName }.sorted { $0 < $1 }.forEach { name in
			print("\t\(name)")
		}
	}

	func selectLayout(layout: String) {
		print("Selecting \(layout)")

		let enabledLayouts = WLKeyboardManager.shared().enabledLayouts()

		var found = false
		enabledLayouts!.forEach { (keyboardSource: WLKeyboardSource) in
			if keyboardSource.localizedName == layout {
				print("found")
				WLKeyboardManager.shared().selectLayout(withID: keyboardSource.inputSourceID)
				found = true
			}
		}

		if !found {
			print("not found")
		}
	}

	func printJSON() {
		let enabledLayouts = WLKeyboardManager.shared().enabledLayouts()
		let array = enabledLayouts?.map {
			return ["title": $0.localizedName!, "arg": $0.localizedName!]
		}

		if let array = array {
			let jsonData = try? JSONSerialization.data(withJSONObject: array,
			                                                 options: .prettyPrinted)

			if let data = jsonData,
				let jsonString = String(data: data, encoding: String.Encoding.utf8) {
				print(jsonString)
			}
		}
	}
}
