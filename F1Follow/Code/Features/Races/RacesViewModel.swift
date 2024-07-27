//
//  RacesViewModel.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import Foundation
import SwiftUI


//class RacesViewModel: ObservableObject {
//    @Published var drivers: [Driver] = []
//    @Published var driverPositions: [DriverPositionClass] = []
//    @Published var laps: [Lap] = []
//    var allPositions: [DriverPositionClass] = []
//    
//    init(session: String) {
//        fetchDrivers(session: session)
//    }
//    
//    func fetch<T: Decodable>(link: String, type: T.Type, completion: @escaping (T) -> Void) {
//        if let url = URL(string: link) {
//            URLSession.shared.dataTask(with: url) { data, _, error in
//                if let data = data, error == nil {
//                    DispatchQueue.main.async {
//                        do {
//                            completion(try JSONDecoder().decode(type, from: data))
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//            }.resume()
//        }
//    }
//    
//    func fetchDrivers(session: String, completion: (() -> Void)? = nil) {
//        fetch(link: "https://api.openf1.org/v1/drivers?session_key=latest", type: [Driver].self) { list in
//            self.drivers = list
//            self.fetchPositions(session: session)
//        }
//    }
//    
//    func fetchPositions(session: String) {
//        fetch(link: "https://api.openf1.org/v1/position?session_key=latest", type: [DriverPositionClass].self) { list in
//            var newPositions: [DriverPositionClass] = []
//            for p in list.reversed() {
//                if !newPositions.contains(where: { $0.driverNumber == p.driverNumber }) {
//                    newPositions.append(p)
//                    if newPositions.count >= 20 {
//                        break
//                    }
//                }
//            }
//            for np in newPositions {
//                if let index = self.drivers.firstIndex(where: { $0.driverNumber == np.driverNumber }) {
//                    self.drivers[index].position = np.position
//                    self.drivers.swapAt(index, np.position-1)
//                }
//            }
//            print("opa")
//        }
//    }
//    
//    func getDriverByNumber(number: Int) -> Driver? {
//        drivers.first { driver in
//            driver.driverNumber == number
//        }
//    }
//}

class RacesViewModel: ObservableObject {
    let session: String
    @Published var drivers: [Driver] = []
    var lastPosition: Position?
    
    
    init(session: String) {
        self.session = session
        
        self.fetchDriver()
    }
    
    func fetchDriver() {
        fetch(link: "https://api.openf1.org/v1/drivers?session_key=\(session)", type: [Driver].self) { drivers in
            self.drivers = drivers
            self.sortDrivers()
            self.refreshDriverLaps()
        }
    }
    
    func sortDrivers() {
        fetch(link: "https://api.openf1.org/v1/position?session_key=\(session)", type: [Position].self) { positions in
            var newPositions: [Position] = []
            for position in positions.reversed() {
                if !newPositions.contains(where: { $0.driverNumber == position.driverNumber }) {
                    if let index = self.drivers.firstIndex(where: { $0.driverNumber == position.driverNumber }) {
                        self.drivers.swapAt(index, position.position-1)
                        newPositions.append(position)
                        if newPositions.count >= 20 {
                            break
                        }
                    }
                }
            }
        }
    }
    
    func refreshDriverLaps() {
        fetch(link: "https://api.openf1.org/v1/laps?session_key=\(session)", type: [Lap].self) { laps in
            for lap in laps {
                if let driver = self.getDriverByNumber(number: lap.driverNumber) {
                    if driver.lastLap == nil || driver.lastLap!.lapNumber < lap.lapNumber {
                        driver.lastLap = lap
                    }
                    if lap.lapDuration != nil {
                        if driver.bestLap == nil || driver.bestLap!.lapDuration! > lap.lapDuration! {
                            driver.bestLap = lap
                        }
                    }
                }
            }
            print("?")
        }
    }
    
    func getDriverByNumber(number: Int) -> Driver? {
        self.drivers.first(where: { $0.driverNumber == number })
    }
}

struct DriverCard: View {
    @ObservedObject var driver: Driver
    @State var liveTime: Double = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text(driver.lastName)
            if let bestLap = driver.bestLap {
                Text(bestLap.lapDuration!.lapTime())
            }
            Text(liveTime.lapTime())
        }
        .monospaced()
        .onReceive(timer, perform: { _ in
            if let lastLap = driver.lastLap {
                liveTime = lastLap.lapLiveTime() ?? 0
            }
        })
    }
}

struct test: View {
    @ObservedObject var racesVM = RacesViewModel(session: "latest")
    var body: some View {
        VStack {
            ForEach(racesVM.drivers, id: \.driverNumber) { driver in
                DriverCard(driver: driver)
            }
        }
    }
}

#Preview {
    test()
}
