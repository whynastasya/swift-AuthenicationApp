//
//  TextEncryptionView.swift
//  AuthenticationApp
//
//  Created by nastasya on 30.11.2023.
//

import SwiftUI
import Foundation

struct SenderView: View {
    @State var text = ""
    @StateObject var dataSource: DataSource
    @State var k: Int = 0
    @State var r: Int = 0
    @State var s: Int = 0
    @State var rLabel: String = ""
    @State var rString = ""
    
    var body: some View {
        VStack {
            Text("Проверяемый")
                .font(.title)
                .padding()
            
//            Text("Открытый ключ y: \(dataSource.schnorrKeyPair.publicKey)")
//            Text("Секретный ключ x: \(dataSource.schnorrKeyPair.privateKey)")
            Text("Открытый ключ y: \(number.y)")
            Text("Секретный ключ x: \(number.x)")
            
            if dataSource.isRSent == false {
                TextField("Введите сообщение", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 300)
                
                Button("Вычислить число r") {
                    withAnimation {
                        k = generateK(q: dataSource.schnorrKeyPair.q)
                        r = calculateR(g: dataSource.schnorrKeyPair.g, k: k, p: dataSource.schnorrKeyPair.p)
                        dataSource.isRCalculated = true
//                        rLabel = "Число r: \(r)"
                        rLabel = "Число r: \(number.r)"
                        dataSource.rString = number.r
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
//            Text(rLabel)
            
            if dataSource.isRCalculated == true && dataSource.isEGenerated == false {
//                Text("Сгенерированное число k: \(k)")
                Text("Сгенерированное число k: \(number.k)")
                
                Text("Число r:")
                TextField("", text: $dataSource.rString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 300)
                    .tint(.green)
                
                Button("Отправить число r") {
                    withAnimation {
                        dataSource.schnorrAuthentication.k = k
                        dataSource.schnorrAuthentication.r = r
                        dataSource.text = text
                        dataSource.isRSent = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            if dataSource.isESent == true && dataSource.isSSent == false {
//                Text("Число e: \(dataSource.schnorrAuthentication.e)")
                Text("Число e: \(number.e)")
                Button("Вычислить число s") {
                    withAnimation {
                        s = calculateS(k: dataSource.schnorrAuthentication.k, x: dataSource.schnorrKeyPair.privateKey, e: dataSource.schnorrAuthentication.e, q: dataSource.schnorrKeyPair.q)
                        dataSource.isSCalculated = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
            
            if dataSource.isSCalculated == true {
//                Text("Число s: \(s)")
                Text("Число s: \(number.s)")
                
                Button("Отправить число s") {
                    withAnimation {
                        dataSource.schnorrAuthentication.s = s
                        dataSource.isSSent = true
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding()
        .background(.green.opacity(0.2))
        .clipShape(.rect(cornerRadius: 30))
    }
    
    func generateK(q: Int) -> Int {
        let qUInt32 = UInt32(q)
        let random = Int(arc4random_uniform(qUInt32 - 1)) + 1
        return random
    }
    
    func calculateR(g: Int, k: Int, p: Int) -> Int {
        var r = NSDecimalNumber(decimal: pow(Decimal(g), k)).intValue
        print(r)
        r = r % p
        return r
    }
    
    func calculateS(k: Int, x: Int, e: Int, q: Int) -> Int {
        let s = (k + x * e) % q
        return s
    }
}

//#Preview {
//    SenderView(dataSource: DataSource(), isPresented: true)
//}
