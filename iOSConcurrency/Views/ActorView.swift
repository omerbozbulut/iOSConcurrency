//
//  ActorView.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import SwiftUI

struct ActorView: View {
    @ObservedObject private var actorViewModel = BankViewModel()
    @ObservedObject private var mainActorViewModel = MainActorViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Actor")
                .font(.system(size: 22))
                .foregroundStyle(.black)
                .bold()
                .padding()
            
            HStack {
                Button {
                    Task{
                        await actorViewModel.calculateAndGetTotalBalance()
                    }
                } label: {
                    Text("Calculate total balance")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
                Text("\(actorViewModel.totalBalance)")
                    .font(.callout)
            }
            .padding()
            
            Divider()
            
            Text("Main Actor")
                .font(.system(size: 22))
                .foregroundStyle(.black)
                .bold()
                .padding()
            
            HStack {
                Spacer()
                Button {
                    mainActorViewModel.addData()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundColor(.cyan)
                        
                        Text("Add Item")
                            .font(.subheadline)
                            .foregroundStyle(.cyan)
                    }
                }
                Spacer()
            }
            
            ZStack{
                List(mainActorViewModel.data, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.callout)
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
        }
    }
}

#Preview {
    ActorView()
}
