//
//  CheckingPrimeNumbersView.swift
//  AuthenticationApp
//
//  Created by nastasya on 29.11.2023.
//

import SwiftUI

struct CheckingPrimeNumbersView: View {
    @StateObject var dataSource: DataSource
    @State private var selectedTest = 0
    @State var isPrimeP = false
    @State var isPrimeQ = false
    @State var isCheckingButtonTapped = false
    @State private var testName = ""
    
    var body: some View {
        VStack {
            Text("Проверка простоты числа")
                .font(.title)
                .padding()
            
            Picker("Выберите тест", selection: $selectedTest) {
                Text("").tag(0)
                Text("Ферма").tag(1)
                Text("Миллер-Рабин").tag(2)
            }
            .pickerStyle(.menu)
            .frame(width: 300)
            .tint(.green)
            
            Button("Проверить простоту") {
                withAnimation {
                    switch selectedTest {
                        case 1:
                            isPrimeP = fermatTest(dataSource.primeNumberP)
                            isPrimeQ = fermatTest(dataSource.primeNumberQ)
                        case 2:
                            isPrimeP = millerRabinTest(dataSource.primeNumberP)
                            isPrimeQ = millerRabinTest(dataSource.primeNumberQ)
                        default:
                            break
                    }
                    dataSource.isPrime = isPrimeP && isPrimeQ
                    testName = selectedTest == 1 ? "Ферма" : "Миллер-Рабина"
                    
                    isCheckingButtonTapped = true
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .padding()
            
            VStack {
                if dataSource.isNumbersGenerated == false && isCheckingButtonTapped == true {
                    Text("Сначала сгенерируйте простые числа")
                        .foregroundStyle(.red)
                } else if selectedTest == 0 && isCheckingButtonTapped == true {
                    Text("Выбери тест для проверки")
                        .foregroundStyle(.red)
                } else if dataSource.isPrime == true {
//                    Text("Тест \(testName): Числа \(dataSource.primeNumberP) и \(dataSource.primeNumberQ) простые")
//                        .foregroundStyle(.green)
                    Text("Тест \(testName): Числа p: \(number.p) и q: \(number.q) простые")
                        .foregroundStyle(.green)
                } else if dataSource.isNumbersGenerated == true && dataSource.isPrime == false && isCheckingButtonTapped == true {
                    Text("Числа \(dataSource.primeNumberP) и \(dataSource.primeNumberQ) непростые")
                        .foregroundStyle(.red)
                }
            }
            .transition(.opacity)
            .animation(.easeInOut)
            
        }
        .padding()
        .background(.green.opacity(0.2))
        .clipShape(.rect(cornerRadius: 30))
    }
    
    func fermatTest(_ number: Int) -> Bool {
        guard number > 1 else {
            return false
        }
        
        if number == 2 || number == 3 {
            return true
        }
        
        for _ in 0 ..< 10 {
            let a = Int.random(in: 2..<number)
            if power(a, number - 1, number) != 1 {
                return false
            }
        }
        
        return true
    }
    
    func power(_ a: Int, _ b: Int, _ m: Int) -> Int {
        if b == 0 {
            return 1
        }
        
        var result = power(a, b / 2, m)
        result = (result * result) % m
        
        if b % 2 == 1 {
            result = (result * a) % m
        }
        
        return result
    }
    
    func decompose(_ n: Int) -> (r: Int, d: Int) {
        var d = n
        var r = 0
        
        while d % 2 == 0 {
            d /= 2
            r += 1
        }
        
        return (r, d)
    }
    
    func millerRabinTest(_ n: Int) -> Bool {
        if n <= 1 {
            return false
        }
        
        let (r, d) = decompose(n - 1)
        
        if n == 2 || n == 3 {
            return true
        }
        
        for _ in 1..<10 {
            let a = Int.random(in: 2...(n - 2))
            var x = power(a, d, n)
            
            if x == 1 || x == n - 1 {
                continue
            }
            
            for _ in 1..<r {
                x = (x * x) % n
                if x == n - 1 {
                    break
                }
            }
            
            if x != n - 1 {
                return false
            }
        }
        
        return true
    }
}

//#Preview {
//    CheckingPrimeNumbersView(dataSource: DataSource())
//}
