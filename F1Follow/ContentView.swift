//
//  ContentView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

enum Pages: CaseIterable {
    case standings, races
    
    var icon: String {
        switch self {
        case .standings:
            "trophy"
        case .races:
            "flag.checkered"
        }
    }
    
    var title: String {
        switch self {
        case .standings:
            "Standings"
        case .races:
            "Races"
        }
    }
}

struct ContentView: View {
    @State var drivers: [Driver] = []
    @State var page: Pages = .races
    
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
                        VStack {
                            Image(systemName: p.icon)
                                .font(.title)
                                .onTapGesture {
                                    page = p
                                }
                            Text(p.title)
                        }
                        .foregroundStyle(p == page ? .blue : .primary)
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
