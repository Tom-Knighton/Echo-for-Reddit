//
//  Date+Echo.swift
//  Env
//
//  Created by Tom Knighton on 03/02/2025.
//

import Foundation

extension Date {
    public var friendlyAgo: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        var ago = String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
        
        let letters = ago.filter({$0.isLetter})
        if letters.count == 1 && letters == "s" {
            ago = "Now"
        }
        
        return ago
    }
    
    public var dynamicDateDifference: String {
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: now)
        
        if let years = components.year, years > 0 {
            if let months = components.month, months > 0 {
                return "\(years)y \(months)m"
            }
            return "\(years)y"
        }
        
        if let months = components.month, months > 0 {
            if let days = components.day, days > 0 {
                return "\(months)m \(days)d"
            }
            return "\(months)m"
        }
        
        if let days = components.day, days > 0 {
            if let hours = components.hour, hours > 0 {
                return "\(days)d \(hours)h"
            }
            return "\(days)d"
        }
        
        if let hours = components.hour, hours > 0 {
            if let minutes = components.minute, minutes > 0 {
                return "\(hours)h \(minutes)m"
            }
            return "\(hours)h"
        }
        
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes)m"
        }
        
        return "Just now"
    }
}
