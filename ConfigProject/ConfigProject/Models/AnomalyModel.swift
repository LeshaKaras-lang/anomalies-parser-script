//
//  AnomalyModel.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

struct AnomalyModel: Decodable {
    let zoneType: String
    let zoneRadius: Int
    let distanceBTWAnomaly: Int
    var anomalyData: String
    let position: [AnomalyModelPosition]
}

struct AnomalyModelPosition: Decodable {
    let position: [Double]
    let comment: String
}
