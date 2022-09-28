//
//  ScoreTracker.swift
//  SetSwiftUI
//
//  Created by Samat Gaynutdinov on 09.07.2022.
//

import Foundation

struct ScoreTracker {
    var score = 0
    
    var dealMoreHappened: Bool = false {
        didSet {
            if dealMoreHappened == true {
                punishForDealMore()
                dealMoreHappened = false
            }
        }
    }
    
    var matchHappened: Bool = false {
        didSet {
            if matchHappened == true {
                rewardForMatch()
                matchHappened = false
            }
        }
    }
    
    var mismatchHappened: Bool = false {
        didSet {
            if mismatchHappened == true {
                punishForMismatch()
                mismatchHappened = false
            }
        }
    }
    
    var deselectionHappened: Bool = false {
        didSet {
            if deselectionHappened == true {
                punishForDeselection()
                deselectionHappened = false
            }
        }
    }
    
    mutating func rewardForMatch() {
        score += Constants.matchReward
    }
    
    mutating func punishForDeselection() {
        score -= Constants.deselectPunishment
    }
    
    mutating func punishForMismatch() {
        score -= Constants.mismatchPunishment
    }
    
    mutating func punishForDealMore() {
        score -= Constants.dealMorePunishment
    }
    
    struct Constants {
        static let deselectPunishment = 1
        static let matchReward = 3
        static let mismatchPunishment = 2
        static let dealMorePunishment = 3
    }
}
