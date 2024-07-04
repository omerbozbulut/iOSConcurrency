//
//  MainActor.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import Foundation

actor DataManager {
    private var data: [String] = []

    func addData(_ item: String) {
        data.append(item)
    }

    func getData() -> [String] {
        return data
    }
}

class MainActorViewModel: ObservableObject {
    var count = 0
    @Published var data: [String] = []
    private let dataManager = DataManager()

    func addData() {
        count += 1
        Task { @MainActor in
            await dataManager.addData("New Item \(count)")
            data = await dataManager.getData()
        }
        
//        Task {
//            await dataManager.addData("New Item \(count)")
//            data = await dataManager.getData()
//        }
    }
}
