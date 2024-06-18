//
//  AnomalyExample.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

enum DynamicAnomaly {
    static func getConfig(for model: AnomalyModel, zonePosition: [Double], comment: String) -> String { return """
{
"_comment": "\(comment)",
    "zoneType": "\(model.zoneType)",
    "zonePosition": \(zonePosition),
    "zoneRadius": \(model.zoneRadius),
    "distanceBTWAnomaly": \(model.distanceBTWAnomaly),
    "checkGeometry": 1,
    "anomalyData": \(model.anomalyData)
}
"""
    }
}
