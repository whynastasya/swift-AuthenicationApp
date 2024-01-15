//
//  Numbers.swift
//  AuthenticationApp
//
//  Created by nastasya on 30.11.2023.
//

import Foundation
import SwiftUI

class DataSource: ObservableObject {
    @Published var primeNumberP = 0
    @Published var primeNumberQ = 0
    @Published var isNumbersGenerated = false
    @Published var isPrime = false
    @Published var isKeysGenerated = false
    @Published var isAuthenticationStarted = false
    @Published var isRCalculated = false
    @Published var isRSent = false
    @Published var isEGenerated = false
    @Published var isESent = false
    @Published var isSCalculated = false
    @Published var isSSent = false
    @Published var isAuthenticationChecked = false
    @Published var text = ""
    @Published var rString = ""
    @Published var schnorrKeyPair = SchnorrKeyPair(p: 0, q: 0, g: 0, privateKey: 0, publicKey: 0)
    @Published var schnorrAuthentication = SchnorrAuthentication(k: 0, r: 0, r1: 0, e: 0, s: 0)
}

struct SchnorrKeyPair {
    var p: Int
    var q: Int
    var g: Int
    var privateKey: Int
    var publicKey: Int
}

struct SchnorrAuthentication {
    var k: Int
    var r: Int
    var r1: Int
    var e: Int
    var s: Int
}

