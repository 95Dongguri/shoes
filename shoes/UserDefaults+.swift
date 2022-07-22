//
//  UserDefaults+.swift
//  shoes
//
//  Created by 김동혁 on 2022/07/18.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case status
    }
    
    var status: [Status] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.status.rawValue) else { return [] }
            
            return (try? PropertyListDecoder().decode([Status].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(
                try? PropertyListEncoder().encode(newValue),
                forKey: Key.status.rawValue)
        }
    }
}
