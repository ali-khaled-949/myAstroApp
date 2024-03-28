//
//  ContentView.swift
//  Moonshot
//
//  Created by Ali Khaled on 03/26/2024
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true 
    

    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    gridLayout
                } else {
                    listLayout
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingGrid.toggle()
                    }) {
                        Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                    }
                }
            }
            .background(.darkBackground)
        }
        .preferredColorScheme(.dark)
    }

    var gridLayout: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(missions) { mission in
                    missionView(mission: mission)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }

    var listLayout: some View {
        List(missions) { mission in
            missionView(mission: mission)
        }
    }

    func missionView(mission: Mission) -> some View {
        NavigationLink {
            MissionView(mission: mission, astronauts: astronauts)
        } label: {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()

                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.lightBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            )
        }
    }
}

// Assuming Bundle.main.decode is defined elsewhere
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
