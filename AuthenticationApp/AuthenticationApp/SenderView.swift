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
    @State var changedW = ""
    @State var changedS = ""
    
    var body: some View {
        VStack {
            Text("Отправитель")
                .font(.title)
                .padding()
            
            //            Text("Открытый ключ y: \(dataSource.schnorrKeyPair.publicKey)")
            //            Text("Секретный ключ x: \(dataSource.schnorrKeyPair.privateKey)")
            Text("Открытый ключ y: \(number.y)")
            Text("Секретный ключ x: \(number.x)")
            
            if !dataSource.isWSSent {
                    TextField("Введите сообщение", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 300)
                    
                    Button("Вычислить хеш-значения") {
                        withAnimation {
                            k = generateK(q: dataSource.schnorrKeyPair.q)
                            r = calculateR(g: dataSource.schnorrKeyPair.g, k: k, p: dataSource.schnorrKeyPair.p)
                            //                        rLabel = "Число r: \(r)"
                            rLabel = "Число k: \(number.k)"
                            dataSource.text = text
                            dataSource.isHCalculated = true
                        }
                }
                
                if dataSource.isHCalculated {
                    if dataSource.isWCalculated == false {
                        Text("h: \(number.p)")
                        Button("Вычислить число k") {
                            withAnimation {
                                k = generateK(q: dataSource.schnorrKeyPair.q)
                                r = calculateR(g: dataSource.schnorrKeyPair.g, k: k, p: dataSource.schnorrKeyPair.p)
                                dataSource.isKCalculated = true
                                //                        rLabel = "Число r: \(r)"
                                rLabel = "Число k: \(number.k)"
                                dataSource.text = text
                                dataSource.isKCalculated = true
                            }
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                    
                    if dataSource.isKCalculated {
                        Text("Число k:\(number.k)")
                        
                        Button("Зашифровать сообщение и подписать его") {
                            withAnimation {
                                dataSource.isWCalculated = true
                            }
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                    
                    if dataSource.isWCalculated {
                        Text("W:\(number.w)")
                        Text("S: \(number.s)")
                        
                        Button("Атака на подпись") {
                            withAnimation {
                                dataSource.isWSChanged = true
                                changedW = "\(number.w)"
                                changedS = "\(number.s)"
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        
                        if dataSource.isWSChanged {
                            TextField("", text: $changedW)
                            TextField("", text: $changedS)
                        }
                        
                        Button("Отправить получателю") {
                            withAnimation {
                                dataSource.isWSSent = true
                                dataSource.text2 = text
                                dataSource.changedS = changedS
                                dataSource.changedW = changedW
                            }
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
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
