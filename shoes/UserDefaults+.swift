//
//  UserDefaults+.swift
//  shoes
//
//  Created by 김동혁 on 2022/07/18.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case statusdata
    }
    
    var statusdata: [StatusData] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.statusdata.rawValue) else { return [] }
            
            return (try? PropertyListDecoder().decode([StatusData].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(
                try? PropertyListEncoder().encode(newValue),
                forKey: Key.statusdata.rawValue)
        }
    }
}
