//  ProcedureStep.swift

import Foundation
class ProcedureStep  {
    //MARK: properties
    let type: StepType
    let step: String
    enum StepType {
        case memory, nonMemory, logic, warning, caution, advisory, note
    }
    //MARK: intitialization
    init(type: StepType, step: String) {
        self.type = type
        self.step = step
    }
}
