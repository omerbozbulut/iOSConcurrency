//
//  PostModel.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}
