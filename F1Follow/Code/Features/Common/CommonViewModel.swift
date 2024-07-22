//
//  CommomViewModel.swift
//  F1Follow
//
//  Created by Emanuel on 22/07/24.
//

import Foundation

class CommonViewModel: ObservableObject {
    @Published var drivers: [Driver] = []
    
    init() {
        let link = "https://api.openf1.org/v1/drivers?session_key=latest"
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        do {
                            self.drivers = try JSONDecoder().decode([Driver].self, from: data)
                        } catch {
                            print(error)
                        }
                    }
                }
            }.resume()
        }
    }
}
