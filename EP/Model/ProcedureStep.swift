//  ProcedureStep.swift

import UIKit
struct ProcedureStep: Codable  {
    let type: StepType
    let step: String
    enum StepType: String, Codable {
        
        case memory, nonMemory, memoryBold, logic, warning, caution, advisory, note, general, list, title, headerWarning, headerCaution, headerNote
    }
}
