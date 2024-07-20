//
//  ContentView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

enum Pages: CaseIterable {
    case standings, races
    
    var icon: Image {
        switch self {
        case .standings:
            Image(systemName: "trophy")
        case .races:
            Image(systemName: "flag.checkered")
        }
    }
}

struct ContentView: View {
    @State var drivers: [Driver] = []
    @State var page: Pages = .standings
    
    var body: some View {
        ZStack {
            
            switch page {
            case .standings:
                StandingsView()
            case .races:
                RacesView()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ForEach(Pages.allCases, id: \.self) { p in
                        p.icon
                            .font(.title)
                            .foregroundStyle(p == page ? .blue : .black)
                            .onTapGesture {
                                page = p
                            }
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
