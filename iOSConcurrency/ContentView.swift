//
//  ContentView.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image("invio_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text("Concurrency")
                    .font(.system(size: 19))
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    CombineView()
                } label: {
                    Text("Show Combine View")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.red.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                NavigationLink {
                    AsyncPokemonView()
                } label: {
                    Text("Show Swift Concurrency View")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                NavigationLink {
                    ActorView()
                } label: {
                    Text("Show Actor View")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
