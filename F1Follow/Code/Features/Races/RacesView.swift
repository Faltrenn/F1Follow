//
//  RacesView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

struct RacesView: View {
    @EnvironmentObject var commonVM: CommonViewModel
    
    var body: some View {
        VStack {
            ForEach(commonVM.drivers, id: \.driverNumber) { driver in
                Text(driver.nameAcronym)
            }
        }
    }
}

#Preview {
    ContentView(page: .races)
}
