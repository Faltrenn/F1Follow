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
    @State var drivers: [Driver] = []
    @State var positions: [Position] = []
    @State var fastestLap: Lap?
    let session: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(positions, id: \.driverNumber) { position in
                    SimpleDriverCard(driver: getDriverByNumber(number: position.driverNumber)!)
                }
            }
        }
        .onAppear {
            fetchDriver()
        }
    }
    
    func fetchDriver() {
        fetch(link: "https://api.openf1.org/v1/drivers?session_key=\(session)", type: [Driver].self) { drivers in
            self.drivers = drivers
            self.fetchPositions()
            self.refreshDriverLaps()
        }
    }
    
    func fetchPositions() {
        fetch(link: "https://api.openf1.org/v1/position?session_key=\(session)", type: [Position].self) { positions in
            for position in positions.reversed() {
                if !self.positions.contains(where: { $0.driverNumber == position.driverNumber }) {
                    if let index = self.drivers.firstIndex(where: { $0.driverNumber == position.driverNumber }) {
                        self.drivers[index].position = position.position
                        self.positions.append(position)
                        if self.positions.count >= 20 {
                            break
                        }
                    }
                }
            }
            self.positions.sort { $0.position < $1.position }
        }
    }
    
    func refreshDriverLaps() {
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
            for driver in self.drivers {
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
        }
    }
    
    func getDriverByNumber(number: Int) -> Driver? {
        self.drivers.first(where: { $0.driverNumber == number })
    }
}

struct SessionsView: View {
    let session: String
    var body: some View {
        VStack {
            NavigationLink {
                ResultsView(session: session)
            } label: {
                Text("Results")
                    .font(.title)
                    .bold()
                    .padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
            .background(.red)
            NavigationLink {
                Text("Replay")
            } label: {
                Text("Replay")
                    .font(.title)
                    .bold()
                    .padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 75, alignment: .leading)
            .background(.red)
        }
        .tint(.primary)
    }
}

#Preview {
    NavigationStack {
        SessionsView(session: "latest")
    }
}
