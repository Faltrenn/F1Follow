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

struct SessionsView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    SessionsView()
}
