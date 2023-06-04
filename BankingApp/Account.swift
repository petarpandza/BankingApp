import Foundation

public struct Account: Codable, Hashable {
    public let accountId: String
    public let accountName: String
    public let balance: Double
    public let cards: [Card]
}

public struct Card: Codable, Hashable {
    public let cardNumber: String
    public let expiryDate: String
    public let cardType: String
    public let cardName: String
    public let transactions: [Transaction]
    public let cardOwner: String
    public let CVV: String
}

public struct Transaction: Codable, Hashable {
    public let name: String
    public let amount: Double
    public let date: Date
}
