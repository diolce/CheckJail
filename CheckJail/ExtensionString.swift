//
//  ExtensionString.swift
//  CheckJail
//
//  Created by Diego Olmo Cejudo on 8/12/20.
//

import Foundation

extension String {
    func xorString() -> String {
        if self.count == 0 {return ""}
        let text = [UInt8](self.utf8)
        var xorResult = [UInt8]()
        let key = [UInt8]("AplicationSwift".utf8)
        let lenght = key.count
        for c in text.enumerated() {
            xorResult.append(c.element ^ key[c.offset % lenght])
        }
        return String(bytes: xorResult, encoding: .utf8) ?? ""
    }
}
