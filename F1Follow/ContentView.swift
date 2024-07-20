//
//  ContentView.swift
//  F1Follow
//
//  Created by Emanuel on 19/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var drivers: [Driver] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(drivers, id: \.driverNumber) { driver in
                    Text(driver.broadcastName)
                        .foregroundStyle(Color(hex: driver.teamColour))
                    
                }
            }
            .padding()
        }
        .onAppear() {
            let url = URL(string: "https://api.openf1.org/v1/drivers?session_key=latest")
            if let url = url {
                URLSession.shared.dataTask(with: url) {data, response, error in
                    if let data = data, error == nil {
                        DispatchQueue.main.async {
                            do {
                                drivers = try JSONDecoder().decode([Driver].self, from: data)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
            }
        }
    }
}

#Preview {
    ContentView()
}
