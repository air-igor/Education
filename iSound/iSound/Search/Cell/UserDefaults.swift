//
//  UserDefaults.swift
//  iSound
//
//  Created by Игорь Попов on 16.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


extension UserDefaults {
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func savedTracks() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedTrack = defaults.object(forKey: UserDefaults.favouriteTrackKey) as? Data else { return [] }
        guard let decodedTrack = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTrack) as? [SearchViewModel.Cell] else { return [] }
        return decodedTrack
    }
}
