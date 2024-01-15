//
//  ContentView.swift
//  AuthenticationApp
//
//  Created by nastasya on 28.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataSource = DataSource()

    var body: some View {
        VStack {
            if dataSource.isAuthenticationStarted == false {
                Text("Сервер")
                    .font(.title)
                    .padding()
                
                HStack {
                    GeneratingPrimeNumbersView(dataSource: dataSource)
                        .transition(.opacity)
                    CheckingPrimeNumbersView(dataSource: dataSource)
                        .transition(.opacity)
                }
                
                HStack {
                    GeneratingCryptographicKeysView(dataSource: dataSource)
                        .transition(.opacity)
                }
            } else {
                HStack {
                    SenderView(dataSource: dataSource)
                        .transition(.opacity)
                        .frame(minWidth: 400)
                    RecipientView(dataSource: dataSource)
                        .transition(.opacity)
                        .frame(minWidth: 400)
                }
                
                Button("Покинуть сессию") {
                    dataSource.isAuthenticationStarted.toggle()
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .font(.title3)
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: dataSource.isAuthenticationStarted)
    }
}




#Preview {
    ContentView()
}
