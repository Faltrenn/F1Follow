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
    var allPositions: [DriverPositionClass] = []
    
    init(session: String) {
        fetchDrivers(session: session)
        fetchDriverPositions(session: session)
    }
    
    func fetch<T: Decodable>(link: String, listType: T.Type, completion: @escaping (T) -> Void) {
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        do {
                            completion(try JSONDecoder().decode(listType, from: data))
                        } catch {
                            print(error)
                        }
                    }
                }
            }.resume()
        }
    }
    
    func fetchDriverPositions(session: String) {
        fetch(link: "https://api.openf1.org/v1/position?session_key=\(session)", listType: [DriverPositionClass].self) { list in
            self.allPositions = list
            for _ in 0..<20 {
                self.driverPositions.append(self.allPositions.removeFirst())
            }
            self.driverPositions.sort { d1, d2 in
                d1.position < d2.position
            }
        }
    }
    
    
    func fetchDrivers(session: String) {
        fetch(link: "https://api.openf1.org/v1/drivers?session_key=\(session)", listType: [Driver].self) { list in
            self.drivers = list
        }
    }
    
    
    func getDriverByNumber(number: Int) -> Driver? {
        drivers.first { driver in
            driver.driverNumber == number
        }
    }
    
    func overtake() {
        withAnimation {
            guard allPositions.count >= 1 else { return }
            
            let o1 = self.allPositions.removeFirst()
            guard let index = driverPositions.firstIndex(where: { d in
                d.driverNumber == o1.driverNumber
            }) else { return }
            
            guard index != o1.position-1 else {
                overtake()
                return
            }
            
            driverPositions.removeAll { d in
                d.driverNumber == o1.driverNumber
            }
            driverPositions.insert(o1, at: o1.position-1)
            
            let inc = (index + 1 - o1.position-1) < 0 ? 1 : -1
            for c in stride(from: index, to: o1.position-1, by: inc) {
                driverPositions[c].position -= inc
            }
        }
    }
}
