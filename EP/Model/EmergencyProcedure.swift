//  EmergencyProcedure.swift

struct EmergencyProcedure: Decodable{
    let shortName: String
    let title: String
    let category: String
    let steps: [ProcedureStep]
}
