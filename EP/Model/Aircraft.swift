//  Aircraft.swift
import Foundation

struct Aircraft: Decodable {
    let tmsID: String
    let tmsName: String
    let aircraftIconImageName: String
    let interimChangeID: String
    let interimChangeDate: String
    let categories: [String]
    let emergencyProcedures: [EmergencyProcedure]
}
