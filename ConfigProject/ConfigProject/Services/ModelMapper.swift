//
//  ModelMapper.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

final class AnomalyModelMapper {
    func mapToString(_ models: [AnomalyModel]) -> String {
        let allConfigs: [String] =  models.flatMap { mapToConfigStrings($0) }
        return "[" + allConfigs.joined(separator: ",") + "]"
    }
    
    private func mapToConfigStrings(_ model: AnomalyModel) -> [String] {
        return model.position.map { position in
            return DynamicAnomaly.getConfig(for: model, zonePosition: position.position, comment: position.comment)
        }
    }
}
