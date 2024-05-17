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
            Text("Получатель")
                .font(.title)
                .padding()
            //            Text("Открытый ключ y: \(dataSource.schnorrKeyPair.publicKey)"
            if dataSource.isWSSent {
                //                Text("Число r: \(dataSource.schnorrAuthentication.r)")
                Text("W: \(number.w)")
                Text("S: \(number.s)")
                Text("h: \(number.p)")
                Text(dataSource.text)
                
                Button("Проверить h") {
                    withAnimation {
                        e = generateE()
                        if dataSource.text == dataSource.text2 {
                            dataSource.isHChecked = true
                        } else {
                            dataSource.isHError = true
                        }
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            if dataSource.isHError {
                Text("Хеш-значения НЕВЕРНЫ")
                    .foregroundStyle(.red)
            }
            
            if dataSource.isHChecked {
                //                Text("Число r: \(dataSource.schnorrAuthentication.r)")
                
                Text("Хеш-значения верны")
                    .foregroundStyle(.green)
                Button("Вычислить v") {
                    withAnimation {
                        e = generateE()
                        dataSource.isVCalculated = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            if dataSource.isVCalculated {
                //                Text("Сгенерированное число e: \(e)")
                Text("v: \(number.a)")
                
                Button("Вычислить числа z1 и z2") {
                    withAnimation {
                        dataSource.schnorrAuthentication.e = e
                        dataSource.isZ1Calculated = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            if dataSource.isZ1Calculated {
                Text("z1: \(number.p)")
                Text("z2: \(number.q)")
                
                Button("Проверка") {
                    withAnimation {
                        r1 = calculateR(g: dataSource.schnorrAuthentication.r, s: dataSource.schnorrAuthentication.s, y: dataSource.schnorrKeyPair.publicKey, e: dataSource.schnorrAuthentication.e, p: dataSource.schnorrKeyPair.p)
                        dataSource.schnorrAuthentication.r1 = r1
                        isPresentedResultView = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.purple)
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
