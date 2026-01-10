//
//  Creature.swift
//  CatchEmAll
//
//  Created by app-kaihatsusha on 10/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}
