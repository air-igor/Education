//
//  CMTime + Extensions.swift
//  iSound
//
//  Created by Игорь Попов on 12.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import  AVKit

extension CMTime {
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let second = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeForatString = String(format: "%02d:%02d", minutes, second)
        return timeForatString
    }
}
