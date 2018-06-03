//  EmergencyProcedure.swift

struct EmergencyProcedure: Codable {
    let shortName: String
    let title: String
    let category: String
    let steps: [ProcedureStep]
}

