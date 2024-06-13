//
//  ContentLoader.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

struct ContentLoader {
    
    enum Error: Swift.Error {
        case incorrectURL(name: String)
        case cannotGetData(name: String)
        case cannotConvertToString(name: String)
        case fileDecodingFailed(name: String, Swift.Error)
    }
    
    let filePrifix: String = "file://"
    let path: String
    let fileNames: [String]
    
    func getAnomalyModels() -> [AnomalyModel] {
        let models: [AnomalyModel] = fileNames.compactMap { fileName -> AnomalyModel? in
            do {
                let model = try loadAnomalyModel(fileName: fileName)
                return try updateAnomalyModelData(model)
            } catch {
                print(error)
                return nil
            }
        }
        return models
    }
    
    private func updateAnomalyModelData(_ model: AnomalyModel) throws -> AnomalyModel {
        var copy: AnomalyModel = model
        let fullPath: String = getPathFor(folder: anomalyDataFolderName, fileName: model.anomalyData)
        
        guard let url = URL(string: fullPath) else {
            throw Error.incorrectURL(name: fullPath)
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw Error.cannotGetData(name: fullPath)
        }
        
        guard let anomalyData: String = String(data: data, encoding: String.Encoding.utf8) else {
            throw Error.cannotConvertToString(name: fullPath)
        }
        
        copy.anomalyData = anomalyData
        return copy
    }
    
    private func loadAnomalyModel(fileName: String) throws -> AnomalyModel {
        let fullPath: String = getPathFor(folder: anomalyConfigFolderName, fileName: fileName)
        
        guard let url = URL(string: fullPath) else {
            throw Error.incorrectURL(name: fullPath)
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw Error.cannotGetData(name: fullPath)
        }
        
        do {
            return try JSONDecoder().decode(AnomalyModel.self, from: data)
        } catch {
            throw Error.fileDecodingFailed(name: fileName, error)
        }
    }
    
    private func getPathFor(folder: String, fileName: String) -> String {
        return filePrifix + path + "/" + folder + "/" + fileName
    }
}
