//
//  RacesView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

struct RacesView: View {
    @EnvironmentObject var commonVM: CommonViewModel
    @ObservedObject var racesVM = RacesViewModel(session: "latest")
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ForEach(racesVM.driverPositions, id: \.driverNumber) { dp in
                        if let driver = racesVM.getDriverByNumber(number: dp.driverNumber) {
                            HStack {
                                Text("\(dp.position)")
                                Text(driver.nameAcronym)
                            }
                        }
                    }
                }
            }
            Button("Overtake") {
                racesVM.overtake()
            }
        }
        .font(.title)
        .monospaced()
    }
}

#Preview {
    ContentView(page: .races)
}
