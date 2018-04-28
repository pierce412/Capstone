//  EmergencyProcedure.swift

class EmergencyProcedure {
    //MARK: properties
    let shortName: String
    let title: String
    let category: String
    let steps: [ProcedureStep]

    //MARK: intitialization
    init(shortName: String, title: String, category: String, steps: [ProcedureStep]) {
        self.shortName = shortName
        self.title = title
        self.category = category
        self.steps = steps
    }
}
