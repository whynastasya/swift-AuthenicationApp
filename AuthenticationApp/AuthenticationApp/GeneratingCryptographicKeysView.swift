//
//  GeneratingCryptographicKeysView.swift
//  AuthenticationApp
//
//  Created by nastasya on 30.11.2023.
//

import SwiftUI

struct GeneratingCryptographicKeysView: View {
    @State private var publicKey = ""
    @State private var privateKey = ""
    @State private var a = ""
    @State private var isGeneratingButtonTapped = false
    @State private var isMessageButtonTapped = false
    @StateObject var dataSource: DataSource
    
    var body: some View {
        VStack {
            Text("Выработка ключей ГОСТ 34.10-94")
                .font(.title)
                .padding()
            
            Button("Сгенерировать ключи") {
                withAnimation {
                    if dataSource.isNumbersGenerated == true {
                        let schnorrKeyPair = generateSchnorrKeyPair()
//                        publicKey = "Открытый ключ: \(schnorrKeyPair.publicKey)"
//                        privateKey = "Закрытый ключ: \(schnorrKeyPair.privateKey)"
                        privateKey = "Cекретный ключ: \(number.x)"
                        a = "Целое число а: \(number.a)"
                        publicKey = "Открытый ключ: \(number.y)"
                        dataSource.schnorrKeyPair = schnorrKeyPair
                        dataSource.isKeysGenerated = true
                    }
                    isGeneratingButtonTapped = true
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            VStack {
                VStack {
                    Text(privateKey)
                    Text(a)
                }
                .padding()
                Text(publicKey)
                
                
                if dataSource.isNumbersGenerated == false && isGeneratingButtonTapped == true {
                    Text("Сначала сгенерируйте простые числа")
                        .foregroundStyle(.red)
                } else if dataSource.isKeysGenerated == false && isGeneratingButtonTapped == true{
                    Text("Сначала сгенерируйте ключи")
                        .foregroundStyle(.red)
                }
                
                if dataSource.isKeysGenerated == true {
                    Button("Публикация ключей") {
                        isMessageButtonTapped = true
                        dataSource.isAuthenticationStarted = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
            }
            .transition(.opacity)
            .animation(.easeInOut)
        }
        .padding()
        .background(.green.opacity(0.2))
        .clipShape(.rect(cornerRadius: 30))
    }
    
    func generateSchnorrKeyPair() -> SchnorrKeyPair {
        let p = dataSource.primeNumberP
        let q = dataSource.primeNumberQ
        
        let x = Int.random(in: 1..<q)
        
        let g = findG(p: p, q: q)
        
        let y = (g.power(x, modulus: p)) % p
        
        return SchnorrKeyPair(p: dataSource.primeNumberP, q: dataSource.primeNumberQ, g: g, privateKey: x, publicKey: y)
    }
    
    func findG(p: Int, q: Int) -> Int {
        for g in 2..<p {
            if (g.power(q, modulus: p) == 1) {
                return g
            }
        }
        fatalError("Cannot find suitable g")
    }
}

//#Preview {
//    GeneratingCryptographicKeysView(dataSource: DataSource())
//}

extension Int {
    func power(_ exp: Int, modulus: Int) -> Int {
        var result = 1
        var base = self
        var exponent = exp
        while exponent > 0 {
            if exponent % 2 == 1 {
                result = (result * base) % modulus
            }
            base = (base * base) % modulus
            exponent /= 2
        }
        return result
    }
}
