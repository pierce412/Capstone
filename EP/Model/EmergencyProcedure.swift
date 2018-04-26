//  EmergencyProcedure.swift

class EmergencyProcedure {
    //MARK: properties
    let shortName: String
    let title: String
    let category: Category
    let steps: [ProcedureStep]
    enum Category {
        case warning, caution, advisory, flight, ground
    }
    
    //MARK: intitialization
    init?(shortName: String, title: String, category: Category, steps: [ProcedureStep]) {
        self.shortName = shortName
        self.title = title
        self.category = category
        self.steps = steps
    }
}
