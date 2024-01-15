//
//  ResultView.swift
//  AuthenticationApp
//
//  Created by nastasya on 30.11.2023.
//

import SwiftUI

struct ResultView: View {
    @StateObject var dataSource: DataSource
    @State var isPresentedResultView: Bool
    
    var body: some View {
        VStack {
//            Text("Число r: \(dataSource.schnorrAuthentication.r)")
            Text("Число r: \(number.r)")
            Text("\(dataSource.rString)")
            if dataSource.rString == number.r  {
                Text("Аутентификация успешна")
                    .foregroundStyle(.green)
                Text(dataSource.text)
            } else {
                Text("Аутентификация не пройдена")
                    .foregroundStyle(.red)
            }
            Button("Закончить сессию") {
                withAnimation {
                    isPresentedResultView = false
                    dataSource.isAuthenticationStarted = false
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
        .padding()
    }
}

//#Preview {
//    ResultView()
//}

