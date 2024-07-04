//
//  Actor.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import Foundation

actor BankAccount {
    private var balance = 0
    
    func deposit(amount: Int) {
        self.balance += amount
    }
    
    func getBalance() -> Int {
        return balance
    }
}

actor Bank {
    private var accounts: [BankAccount] = []
    
    func addAccount(account: BankAccount) {
        accounts.append(account)
    }
    
    func totalBalance() async -> Int {
        var total = 0
        for account in accounts {
            total += await account.getBalance()
        }
        return total
    }
}

class BankViewModel: ObservableObject {
    private let bank = Bank()
    private let account1 = BankAccount()
    private let account2 = BankAccount()
    @Published var totalBalance = 0
    
    init() {
        Task {
            await bank.addAccount(account: account1)
            await bank.addAccount(account: account2)
        }
    }
    
    func calculateAndGetTotalBalance() async {
        await self.account1.deposit(amount: 100)
        await self.account2.deposit(amount: 200)
        
        let balance = await bank.totalBalance()
        DispatchQueue.main.async {
            self.totalBalance = balance      // Published must be main
        }
    }
}
