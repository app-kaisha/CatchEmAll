//
//  Creatures.swift
//  CatchEmAll
//
//  Created by app-kaihatsusha on 09/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//
// https://pokeapi.co/api/v2/pokemon/
// "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20"

import Foundation

@Observable // Watch objects for changes so SwiftUI will redraw interface when needed
class Creatures {
    
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    var creaturesArray: [Creature] = []
    var isLoading = false
    
    func getData() async {
        
        //print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode JSON into data structure
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
        
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            
            // Confirm data was decoded:
            // print("😎 JSON returned! count: \(returned.count), next: \(returned.next)")
            Task { @MainActor in
                self.count = returned.count
                self.urlString = returned.next ?? ""
                self.creaturesArray = self.creaturesArray + returned.results
                isLoading = false
            }

            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            
            // guard for last page reached
            guard urlString.hasPrefix("http") else { return }
            
            await getData()
            // recurssion - call self until all data retrieved
            await loadAll()
        }
        
    }
    
}
