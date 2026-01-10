//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by app-kaihatsusha on 09/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct CreaturesListView: View {
    
    @State var creatures = Creatures()
    
    var body: some View {
        NavigationStack {
            Text("Come back and fix later")
            List(creatures.creaturesArray, id: \.self) { creature in
                NavigationLink {
                    DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            // Async task
            await creatures.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
