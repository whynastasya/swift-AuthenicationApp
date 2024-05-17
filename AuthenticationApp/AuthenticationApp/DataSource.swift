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
    @Published var isHCalculated = false
    @Published var isKeysGenerated = false
    @Published var isAuthenticationStarted = false
    @Published var isKCalculated = false
    @Published var isWCalculated = false
    @Published var isHChecked = false
    @Published var isSCalculated = false
    @Published var isWSSent = false
    @Published var isVCalculated = false
    @Published var isZ1Calculated = false
    @Published var isZ2Calculated = false
    @Published var isUCalculated = false
    @Published var isAuthenticationChecked = false
    @Published var isHError = false
    @Published var isWSChanged = false
    @Published var changedW = ""
    @Published var changedS = ""
    @Published var text = ""
    @Published var text2 = ""
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

