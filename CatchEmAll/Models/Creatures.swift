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
    
    struct Result: Codable, Hashable {
        var name: String
        var url: String
    }
    
    private struct Returned: Codable {
        var count: Int
        var next: String // TODO: change to optional
        var results: [Result]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon/"
    var count = 0
    var creaturesArray: [Result] = []
    
    func getData() async {
        
        print("🕸️ We are accessing the url \(urlString)")
        
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode JSON into data structure
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
        
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            
            // Confirm data was decoded:
            // print("😎 JSON returned! count: \(returned.count), next: \(returned.next)")
            
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    
}
