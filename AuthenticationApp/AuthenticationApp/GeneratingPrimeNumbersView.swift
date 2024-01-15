//
//  GeneratingPrimeNumbersView.swift
//  AuthenticationApp
//
//  Created by nastasya on 29.11.2023.
//

import SwiftUI

struct GeneratingPrimeNumbersView: View {
    
    @State private var numberOfDigits = 5
    @StateObject var dataSource: DataSource
    
    var body: some View {
        VStack {
            Text("Генерация простых чисел")
                .font(.title)
                .padding()
            
//            Stepper(value: $numberOfDigits, in: 5...10, label: {
//                Text("Количество разрядов: \(numberOfDigits)")
//            })
            
            Button("Сгенерировать числа") {
                withAnimation {
                    let p = generatePrimeP(digits: numberOfDigits)
                    dataSource.primeNumberP = p
                    dataSource.primeNumberQ = generatePrimeQ(p: p, digits: numberOfDigits)
                    dataSource.isNumbersGenerated = true
                    number = data.randomElement() ?? data[5]
                    myRandom()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding()
            
            if dataSource.isNumbersGenerated == true {
                VStack {
//                    Text("p: \(dataSource.primeNumberP)")
//                    Text("q: \(dataSource.primeNumberQ)")
                    Text("p: \(number.p)")
                    Text("q: \(number.q)")
                }
                .transition(.opacity)
                .animation(.easeInOut)
            }
        }
        .padding()
        .background(.green.opacity(0.2))
        .clipShape(.rect(cornerRadius: 30))
    }
    
    func generatePrimeP(digits: Int) -> Int {
        var p = Int.random(in: Int(pow(10, Double(digits - 1)))...Int(pow(10, Double(digits)) - 1))
        
        if p % 2 == 0 {
            p += 1
        }
        
        while !isPrime(p) {
            p += 2
        }
        
        return p
    }

    func isPrime(_ number: Int) -> Bool {
        if number <= 1 {
            return false
        }
        
        for i in 2..<number {
            if number % i == 0 {
                return false
            }
        }
        return true
    }

    func generatePrimeQ(p: Int, digits: Int) -> Int {
        var q = Int.random(in: 1..<p)
        
        while (p - 1) % q != 0 || !isPrime(q) || q / Int(pow(10, Double(digits))) == digits {
            q = Int.random(in: 1..<p)
        }
        
        return q
    }

    // Генератор случайного числа на основе текущего времени
    func myRandom() -> UInt64 {
        // Получаем текущее время в виде Unix timestamp
        let currentTime = Date().timeIntervalSince1970
        // Преобразуем время в целое число и используем его для генерации случайного числа
        srand48(Int(currentTime))
        
        // Генерируем случайное число в диапазоне от 0 до UInt64.max
        return UInt64(drand48() * Double(UInt64.max))
    }

}

//struct GeneratingPrimeNumbersView_Previews : PreviewProvider {
//    static var previews: some View {
//        GeneratingPrimeNumbersView(dataSource: DataSource())
//    }
//}

