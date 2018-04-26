//  Aircraft.swift

import Foundation

class Aircraft {
    let tmsID: String
    let tmsName: String
    let aircraftIconImageName: String
    let interimChangeID: String
    let interimChangeDate: Date
    let emergencyProcedures: [EmergencyProcedure]
    
    init(tmsID: String, tmsName: String, aircraftIconImageName: String, interimChangeID: String, interimChangeDate: Date, emergencyProcedures: [EmergencyProcedure])
    {
        self.tmsID = tmsID
        self.tmsName = tmsName
        self.aircraftIconImageName = aircraftIconImageName
        self.interimChangeID = interimChangeID
        self.interimChangeDate = interimChangeDate
        self.emergencyProcedures = emergencyProcedures
    }
}
