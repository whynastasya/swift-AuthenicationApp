//
//  TextDecryptionView.swift
//  AuthenticationApp
//
//  Created by nastasya on 30.11.2023.
//

import SwiftUI

struct RecipientView: View {
    @State var text = ""
    @StateObject var dataSource: DataSource
    @State var e: Int = 0
    @State var r1: Int = 0
    @State var isPresentedResultView = false

    var body: some View {
        VStack {
            Text("Проверяющий")
                .font(.title)
                .padding()
//            Text("Открытый ключ y: \(dataSource.schnorrKeyPair.publicKey)")
            Text("Открытый ключ y: \(number.y)")
            if dataSource.isRSent == true && dataSource.isEGenerated == false {
//                Text("Число r: \(dataSource.schnorrAuthentication.r)")
                Text("Число r: \(number.r)")
                
                Button("Сгенирировать число e") {
                    withAnimation {
                        e = generateE()
                        dataSource.isEGenerated = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            if dataSource.isEGenerated == true && dataSource.isSCalculated == false {
//                Text("Сгенерированное число e: \(e)")
                Text("Сгенерированное число e: \(number.e)")
                Button("Отправить число e") {
                    withAnimation {
                        dataSource.schnorrAuthentication.e = e
                        dataSource.isESent = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            if dataSource.isSSent == true {
//                Text("Число s: \(dataSource.schnorrAuthentication.s)")
                Text("Число s: \(number.s)")
                Button("Проверка аутентификации") {
                    withAnimation {
                        r1 = calculateR(g: dataSource.schnorrAuthentication.r, s: dataSource.schnorrAuthentication.s, y: dataSource.schnorrKeyPair.publicKey, e: dataSource.schnorrAuthentication.e, p: dataSource.schnorrKeyPair.p)
                        dataSource.schnorrAuthentication.r1 = r1
                        isPresentedResultView = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .sheet(isPresented: $isPresentedResultView, content: {
                    ResultView(dataSource: dataSource, isPresentedResultView: isPresentedResultView)
                })
            }
        }
        .padding()
        .background(.green.opacity(0.2))
        .clipShape(.rect(cornerRadius: 30))
    }
    
    func generateE() -> Int {
        return 3
    }
    
    func calculateR(g: Int, s: Int, y: Int, e: Int, p: Int) -> Int {
        let base = modPow(base: g, exponent: s, modulus: p)
        let exponent = modPow(base: y, exponent: e, modulus: p)
        
        let r = (base * exponent) % p
        return r
    }

    func modPow(base: Int, exponent: Int, modulus: Int) -> Int {
        var result = 1
        var baseValue = base % modulus
        
        var exponentValue = exponent
        
        while exponentValue > 0 {
            if exponentValue % 2 == 1 {
                result = (result * baseValue) % modulus
            }
            
            baseValue = (baseValue * baseValue) % modulus
            exponentValue /= 2
        }
        
        return result
    }
}

//#Preview {
//    RecipientView(dataSource: DataSource, isPresented: Binding<Bool>)
//}
