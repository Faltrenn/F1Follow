//
//  RacesViewModel.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import Foundation
import SwiftUI


class RacesViewModel: ObservableObject {
    @Published var drivers: [Driver] = []
    @Published var driverPositions: [DriverPositionClass] = []
    @Published var laps: [LapClass] = []
    var allPositions: [DriverPositionClass] = []
    
    init(session: String) {
        fetchDrivers(session: session)
        fetchDriverPositions(session: session)
        fetchLaps(session: session)
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(testFetch), userInfo: nil, repeats: true)

    }
    
    func fetch<T: Decodable>(link: String, type: T.Type, completion: @escaping (T) -> Void) {
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        do {
                            completion(try JSONDecoder().decode(type, from: data))
                        } catch {
                            print(error)
                        }
                    }
                }
            }.resume()
        }
    }
    
    func fetchLaps(session: String) {
        fetch(link: "https://api.openf1.org/v1/laps?session_key=\(session)", type: [LapClass].self) { list in
            var newLaps: [LapClass] = []
            for l in list.reversed() {
                if !newLaps.contains(where: { $0.driverNumber == l.driverNumber}) {
                    newLaps.append(l)
                    if let index = self.laps.firstIndex(where:{ $0.driverNumber == l.driverNumber }) {
                        self.laps[index] = l
                    } else {
                        self.laps.append(l)
                    }
                }
            }
        }
    }
    
    func fetchDriverPositions(session: String) {
        fetch(link: "https://api.openf1.org/v1/position?session_key=\(session)", type: [DriverPositionClass].self) { list in
            self.allPositions = list
            var newPositions: [DriverPositionClass] = []
            for pos in list.reversed() {
                if !newPositions.contains(where: { $0.driverNumber == pos.driverNumber}) {
                    newPositions.append(pos)
                    if newPositions.count >= 20 {
                        break
                    }
                }
            }
            self.driverPositions = newPositions
//            for _ in 0..<20 {
//                self.driverPositions.append(self.allPositions.removeFirst())
//            }
            self.driverPositions.sort { d1, d2 in
                d1.position < d2.position
            }
        }
    }
    
    func fetchDrivers(session: String) {
        fetch(link: "https://api.openf1.org/v1/drivers?session_key=\(session)", type: [Driver].self) { list in
            self.drivers = list
        }
    }
    
    func getDriverByNumber(number: Int) -> Driver? {
        drivers.first { driver in
            driver.driverNumber == number
        }
    }
    
    @objc func testFetch() {
        fetchLaps(session: "latest")
        fetchDriverPositions(session: "latest")
        
//        var apiValues: [DriverPositionClass] = []
//        let length = Int.random(in: 0...4)
//        for _ in 0..<length {
//            guard allPositions.count > 0 else { break }
//            apiValues.append(allPositions.removeFirst())
//        }
//
//        var newValues: [DriverPositionClass] = []
//        for dp in apiValues.reversed() {
//            if newValues.first(where: { $0.driverNumber == dp.driverNumber }) == nil {
//                newValues.append(dp)
//            }
//        }
// 
//        guard newValues.count >= 1 else { return }
//        makeOvertakes(overtakes: &newValues)
    }
    
    func makeOvertakes(overtakes: inout [DriverPositionClass]) {
        withAnimation {
            while overtakes.count != 0 {
                let nv = overtakes.removeFirst()
                let index = driverPositions.firstIndex(where: { $0.driverNumber == nv.driverNumber })
                if let index = index, index != nv.position-1 {
                    driverPositions.remove(at: index)
                    driverPositions.insert(nv, at: nv.position-1)
                    
                    // Reposicionando todos no caminho
                    let inc = (index + 1 - nv.position-1) < 0 ? 1 : -1
                    for c in stride(from: index, to: nv.position-1, by: inc) {
                        driverPositions[c].position -= inc
                    }
                }
            }
        }
    }
    
    func endRace() {
        var lastValues: [DriverPositionClass] = []
        for p in allPositions.reversed() {
            if !lastValues.contains(where: { $0.driverNumber == p.driverNumber}) {
                lastValues.insert(p, at: 0)
            }
        }
        allPositions = []
        lastValues.sort { $0.position > $1.position }
        makeOvertakes(overtakes: &lastValues)
    }
}
