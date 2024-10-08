//
//  SessionsView.swift
//  F1Follow
//
//  Created by Emanuel on 28/07/24.
//

import SwiftUI

struct SessionCard: View {
    let session: Session
    
    var body: some View {
        HStack {
            VStack {
                Text("Dia")
                Text("Mes")
                    .padding(.horizontal)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .leading) {
                Text(session.sessionName)
                    .font(.title2)
                    .bold()
                Text("Veja os detalhes")
                    .font(.caption2)
            }
        }
        .tint(.primary)
    }
}

struct ResultsView: View {
    @Binding var drivers: [Driver]
    @Binding var positions: [Position]
    @State var fastestLap: Lap?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(positions, id: \.driverNumber) { position in
                    SimpleDriverCard(driver: getDriverByNumber(number: position.driverNumber)!)
                }
            }
        }
    }
    
    func getDriverByNumber(number: Int) -> Driver? {
        self.drivers.first(where: { $0.driverNumber == number })
    }
}

struct SessionsView: View {
    @State var positions: [Position] = []
    @State var ranking: [Position] = []
    @State var drivers: [Driver] = []
    let session: String
    var body: some View {
        VStack {
            if ranking.count > 0 && drivers.count > 0 {
                NavigationLink {
                    ResultsView(drivers: $drivers, positions: $ranking)
                } label: {
                    Text("Results")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
                .background(.red)
            } else {
                ProgressView()
            }
        }
        .tint(.primary)
        .onAppear {
            fetchPositions()
            fetchRanking()
            fetchDrivers()
            fetchLaps()
        }
    }
    
    func fetchDrivers() {
        fetch(link: "https://api.openf1.org/v1/drivers?session_key=\(session)", type: [Driver].self) { drivers in
            self.drivers = drivers
        }
    }
    
    func fetchPositions() {
        fetch(link: "https://api.openf1.org/v1/position?session_key=\(session)", type: [Position].self) { positions in
            self.positions = positions
        }
    }
    
    func fetchRanking() {
        fetch(link: "https://api.openf1.org/v1/position?session_key=\(session)", type: [Position].self) { positions in
            for position in positions.reversed() {
                if !self.ranking.contains(where: { $0.driverNumber == position.driverNumber }) {
                    if let index = self.drivers.firstIndex(where: { $0.driverNumber == position.driverNumber }) {
                        withAnimation {
                            self.drivers[index].position = position.position
                            self.drivers.swapAt(index, position.position-1)
                        }
                        self.ranking.append(position)
                        if self.ranking.count >= 20 {
                            break
                        }
                    }
                }
            }
            self.ranking.sort { $0.position < $1.position }
        }
    }
    
    func fetchLaps() {
        fetch(link: "https://api.openf1.org/v1/laps?session_key=\(session)", type: [Lap].self) { laps in
            var bestSectors: [Double] = [0, 0, 0]
            for lap in laps {
                for c in 0...2 {
                    if let time = lap.sectorsTimes[c] {
                        if time < bestSectors[c] {
                            bestSectors[c] = time
                        }
                    }
                }
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
            var bestSessionLapDriver: Driver?
            for driver in self.drivers {
                if let bl = driver.bestLap {
                    if bestSessionLapDriver == nil || bestSessionLapDriver!.bestLap!.lapDuration! > bl.lapDuration! {
                        bestSessionLapDriver = driver
                    }
                }
                if let lap = driver.lastLap {
                    for c in 0...2 {
                        if let lapTime = lap.sectorsTimes[c] {
                            withAnimation {
                                if lapTime == bestSectors[c] {
                                    driver.sectors[c] = .purple
                                } else if lapTime <= driver.bestSectors[c] {
                                    driver.sectors[c] = .green
                                } else {
                                    driver.sectors[c] = .yellow
                                }
                            }
                        }
                    }
                }
            }
            bestSessionLapDriver?.bestSessionLap = true
        }
    }
    
    
    func getDriverByNumber(number: Int) -> Driver? {
        self.drivers.first(where: { $0.driverNumber == number })
    }
}

#Preview {
    NavigationStack {
        SessionsView(session: "latest")
    }
}
