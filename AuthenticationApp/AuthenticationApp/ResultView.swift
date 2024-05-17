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
            Text("Число u: \(number.w)")
            Text("\(dataSource.rString)")
            if dataSource.changedW == "" || dataSource.changedS == "" {
                Text("Подлинность подписи подтверждена")
                    .foregroundStyle(.green)
                Text(dataSource.text)
            } else {
                Text("Подпись не подлинна")
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

