//
//  ChartData.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation

struct ChartData: Identifiable, Equatable {

    let id = UUID()
    let name: String
    
    let minX: Double
    let maxX: Double
    
    let minY: Double
    let maxY: Double

    let entries: [Entry]
    
    let yAxisValues: [Double]
    let xAxisValues: [Double]
    
    let defaultAxisValues: [Double]
    
    init(name: String, entries: [Entry]) {
        self.entries = entries
        
        self.minX = entries.min(by: { $0.x < $1.x }).map({ $0.x }) ?? Double.greatestFiniteMagnitude
        self.maxX = entries.max { $0.x < $1.x }.map({ $0.x }) ?? 0.0 
        
       
        self.minY = entries.min(by: { $0.y < $1.y }).map({ $0.y }) ?? Double.greatestFiniteMagnitude
        self.maxY = entries.max { $0.y < $1.y }.map({ $0.y }) ?? 0.0
        
        let strideBy = Double(entries.count) / 100.0

        self.xAxisValues = Array(stride(from: self.minX, through: self.maxX, by: (self.maxX - self.minX) / strideBy))
        self.yAxisValues = Array(stride(from: self.minY, through: self.maxY, by: (self.maxY - self.minY) / strideBy))
        
        self.defaultAxisValues = Array(stride(from: 0, to: 1, by: 1.0/strideBy))
        self.name = name
        
        print("\(self.minX) \(self.maxX) \(self.minY) \(self.maxY)")
    }
    
    
    struct Entry: Identifiable, Equatable {
        let x: Double
        let y: Double
        
        var id: String { "\(x)-\(y)" }
    }
}

