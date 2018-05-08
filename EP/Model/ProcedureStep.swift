//  ProcedureStep.swift

import UIKit
struct ProcedureStep: Decodable  {
    let type: StepType
    let step: String
    enum StepType: String, Decodable {
        case memory, nonMemory, memoryBold, logic, warning, caution, advisory, note, general, list
    }
}
