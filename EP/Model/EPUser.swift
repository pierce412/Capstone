//  EPUser.swift
import Foundation
class EPUser {
    let uuid: UUID
    let email: String
    let purchasedAircraft: [String]
    
    init(uuid: UUID, email: String, purchasedAircraft: [String]){
        self.uuid = uuid
        self.email = email
        self.purchasedAircraft = purchasedAircraft
    }
}
