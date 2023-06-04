import Foundation

extension Account {
    static func example() -> [Account] {
        let calendar = Calendar.current
        
        let spending1:[Transaction] = [
            Transaction(name: "Decentia", amount: -8.19,
                        date: calendar.date(from: DateComponents(year: 2023, month: 6, day: 3))!),
            Transaction(name: "Mlinar", amount: -2.40,
                        date: calendar.date(from: DateComponents(year: 2023, month: 6, day: 2))!),
            Transaction(name: "Stipendija", amount: 300,
                        date: calendar.date(from: DateComponents(year:2023, month:6, day:1))!)]
        
        let spending2:[Transaction] = [
            Transaction(name: "Bolt Ride", amount: -4.51,
                        date: calendar.date(from: DateComponents(year: 2023, month: 4, day: 4))!)]
        
        let card1: Card = Card(cardNumber: "1234123412341234", expiryDate: "04/26", cardType: "Debit Mastercard", cardName: "Ime kartice 1", transactions: spending1, cardOwner: "Ivo Ivić", CVV:"123")
        
        let card2: Card = Card(cardNumber: "1111222233334444", expiryDate: "08/27", cardType: "Credit Mastercard", cardName: "Proizvoljno ime 2", transactions: spending2, cardOwner: "Ivo Ivić", CVV:"456")
        
        let account: Account = Account(accountId: "1234567890", accountName: "Moj Račun", balance: 1324.6587, cards: [card1, card2])
        
        return [account]
    }
}
