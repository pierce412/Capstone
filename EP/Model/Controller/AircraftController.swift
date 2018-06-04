//  AircraftController.swift
import UIKit
import Firebase
import NotificationCenter

class AircraftController {
    var allAircraft: [Aircraft] = [] {
        didSet {
            //notification to reload listTableView in AircraftListViewController
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    static let shared = AircraftController()
    let baseURL = URL(string: "https://emergencyprocedure-42955.firebaseio.com/")
    
    func fetchAircraftFromServer() {
        guard let url = baseURL?.appendingPathComponent("Aircraft").appendingPathExtension("json") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    print("Data received from server")
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    let aircraft = try jsonDecoder.decode([Aircraft].self, from: data)
                    self.allAircraft = aircraft
                }
                catch let e {
                    print("Error decoding aircraft: \(e.localizedDescription)")
                    return
                }
            }
        }
        dataTask.resume()
    }
    // MARK: - Local persistence
    func fileURL() -> URL  {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fullURL = documentsDirectory[0].appendingPathComponent("Aircraft").appendingPathExtension("json")
        print("URL: \(fullURL)")
        return fullURL
    }
    func saveToPersistentStorage() {
        do {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(allAircraft)
            try data.write(to: fileURL(), options: .noFileProtection)
        }
        catch let error {
            print("Error saving to disk: \(error)")
        }
        print("SAVED TO DISK")
    }
    func loadFromPersistentStorage() -> [Aircraft] {
        do {
            print("LOADED FROM DISK")
            let jsonDecoder = JSONDecoder()
            let data = try Data(contentsOf: fileURL())
            let allAircraft = try jsonDecoder.decode([Aircraft].self, from: data)
            return allAircraft
        }
        catch let error {
            print("Error loading from disk: \(error)")
        }
        return []
    }
    
    func configureAircraftForDisplay(aircraft: Aircraft) -> [[EmergencyProcedure]] {
        var arrToReturn = [[EmergencyProcedure]]()
        let categories = aircraft.categories
        for (index, _) in categories.enumerated() {
            var rowArray = [EmergencyProcedure]()
            for ep in aircraft.emergencyProcedures {
                if(ep.category == categories[index]){
                    rowArray.append(ep)
                }
            }
            arrToReturn.append(rowArray)
        }
        return arrToReturn
    }
    
    init() {
        // let userIsVerified = Auth.auth().currentUser?.isEmailVerified else { return }
        
        fetchAircraftFromServer()
        //saveToPersistentStorage()
        // guard let isVerified = Auth.auth().currentUser?.isEmailVerified else { return }
        //if(isEmailVerified){
        
        
        //otherwise load from store
        //allAircraft =  loadFromPersistentStorage()
    }
}


/*
 let step1a = ProcedureStep(type: .memory, step: "1. Do something")
 let step1b = ProcedureStep(type: .logic, step: "2. Do something more")
 let step1c = ProcedureStep(type: .note, step: "3. Do something else")
 let step1d = ProcedureStep(type: .memory, step: "4. Do something ok")
 
 let steps = [step1a, step1b, step1c, step1d]
 
 let step2a = ProcedureStep(type: .memory, step: "1. Do something")
 let step2b = ProcedureStep(type: .memory, step: "2. Do something more")
 let step2c = ProcedureStep(type: .memory, step: "3. Do something else")
 let step2d = ProcedureStep(type: .memory, step: "4. Do something ok V-22")
 
 let steps2 = [step2a, step2b, step2c, step2d]
 let ep1 = EmergencyProcedure(shortName: "fireEngineGround", title: "V22Fire eng ground", category: Constants.warning , steps: steps)
 let ep2 = EmergencyProcedure(shortName: "fireInFlight", title: "Fire - In Flight", category: Constants.caution, steps: steps2)
 
 let epArray = [ep1, ep2]
 
 let date = Date()
 let aircraft1 = Aircraft(tmsID: "MV22", tmsName: "MV-22B/C Osprey", aircraftIconImageName: "", interimChangeID: "1-1", interimChangeDate: date, categories: ["warning", "caution", "advisory", "flight", "ground"], emergencyProcedures: epArray)
 
 
 let step3a = ProcedureStep(type: .memory, step: "1. Do something")
 let step3b = ProcedureStep(type: .memory, step: "2. Do something more")
 let step3c = ProcedureStep(type: .memory, step: "3. Do something else")
 let step3d = ProcedureStep(type: .memory, step: "4. Do something ok")
 
 let steps3 = [step3a, step3b, step3c, step3d]
 
 let step4a = ProcedureStep(type: .memory, step: "1. Do something")
 let step4b = ProcedureStep(type: .memory, step: "2. Do something more")
 let step4c = ProcedureStep(type: .memory, step: "3. Do something else")
 let step4d = ProcedureStep(type: .memory, step: "4. Do something yankeeish")
 
 let steps4 = [step4a, step4b, step4c, step4d]
 
 let ep3 = EmergencyProcedure(shortName: "fireEngineGround", title: "Yankee Fire eng ground", category: Constants.warning, steps: steps3)
 let ep4 = EmergencyProcedure(shortName: "fireInFlight", title: "Yankee Fire - In Flight", category: Constants.caution, steps: steps4)
 
 
 let epArray2 = [ep3, ep4]
 
 let date2 = Date()
 let aircraft2 = Aircraft(tmsID: "UH1Y", tmsName: "UH-1Y Huey", aircraftIconImageName: "", interimChangeID: "2-1", interimChangeDate: date2, categories: ["warning", "caution", "advisory", "flight", "ground"],emergencyProcedures: epArray2)
 
 
 let step5a = ProcedureStep(type: .memory, step: "1. Do something")
 let step5b = ProcedureStep(type: .memory, step: "2. Do something more")
 let step5c = ProcedureStep(type: .memory, step: "3. Do something else")
 let step5d = ProcedureStep(type: .memory, step: "4. Drogue applies here")
 
 let steps5 = [step5a, step5b, step5c, step5d]
 
 let step6a = ProcedureStep(type: .memory, step: "1. This is electrical fail")
 let step6b = ProcedureStep(type: .memory, step: "2. Do something more")
 let step6c = ProcedureStep(type: .memory, step: "3. Do something else")
 let step6d = ProcedureStep(type: .memory, step: "4. Do something yankeeish")
 
 let steps6 = [step6a, step6b, step6c, step6d]
 
 let ep5 = EmergencyProcedure(shortName: "hydFail", title: "Hydraulic Failure", category: Constants.hydraulic, steps: steps5)
 let ep6 = EmergencyProcedure(shortName: "electricFail", title: "Electrical failure", category: Constants.electric, steps: steps6)
 let ep7 = EmergencyProcedure(shortName: "fuelProblem", title: "Stuck Fuel", category: Constants.fuel, steps: steps6)
 let ep8 = EmergencyProcedure(shortName: "oxygenFail", title: "Oxygen Fail", category: Constants.o2, steps: steps6)
 let ep9 = EmergencyProcedure(shortName: "engChips", title: "Engine Chips", category: Constants.engine, steps: steps6)
 let ep10 = EmergencyProcedure(shortName: "takeoff", title: "Engine Failure on takeoff", category: Constants.takeoff, steps: steps6)
 let ep11 = EmergencyProcedure(shortName: "general1", title: "General - ditching", category: Constants.general, steps: steps6)
 let ep12 = EmergencyProcedure(shortName: "general2", title: "General - hitting tanker", category: Constants.general, steps: steps6)
 let ep13 = EmergencyProcedure(shortName: "trappedFuel", title: "Trapped Fuel", category: Constants.fuel, steps: steps6)
 let ep14 = EmergencyProcedure(shortName: "fuelQtyInd", title: "Fuel Quantity Indicator", category: Constants.fuel, steps: steps6)
 let ep15 = EmergencyProcedure(shortName: "fuelFlow", title: "Fuel Flow erratic", category: Constants.fuel, steps: steps6)
 let ep16 = EmergencyProcedure(shortName: "fuelDrain", title: "Drain - Fuel", category: Constants.fuel, steps: steps6)
 let ep17 = EmergencyProcedure(shortName: "fuelTank", title: "Feed Tank Low", category: Constants.fuel, steps: steps6)
 let ep18 = EmergencyProcedure(shortName: "grdp", title: "GRDP Fail", category: Constants.fuel, steps: steps6)
 let ep19 = EmergencyProcedure(shortName: "drogue", title: "Drogue fails to extend", category: Constants.fuel, steps: steps6)
 
 
 let epArray3 = [ep5, ep6, ep7, ep8, ep9, ep10, ep11, ep12, ep13, ep14, ep15, ep16, ep17, ep18, ep19]
 
 let date3 = Date()
 let aircraft3 = Aircraft(tmsID: "T6B", tmsName: "T-6B Texan", aircraftIconImageName: "", interimChangeID: "4-1", interimChangeDate: date3, categories: ["hydraulic", "electric", "fuel", "o2", "engine", "takeoff", "general"], emergencyProcedures: epArray3)
 
 
 allAircraft.append(aircraft1)
 allAircraft.append(aircraft2)
 allAircraft.append(aircraft3)
 */

