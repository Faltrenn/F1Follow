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

struct SessionsView: View {
    var body: some View {
        VStack {
            NavigationLink {
                Text("Results")
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
        SessionsView()
    }
}
