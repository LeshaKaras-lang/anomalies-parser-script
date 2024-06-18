//
//  main.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

typealias ProjectPath = String
let anomalyConfigFolderName: String = "AnomalyConfigs"
let anomalyDataFolderName: String = "AnomalyData"
var projectPath: String? = "/Users/oleksii/Projects/Configs"

func start() {
    if projectPath == nil {
        let path = InputHelper().inputFolder()
        projectPath = path
    }
    guard let projectPath else { return }
    
    do {
        let fileNames: [String] = try LoadDataService.loadAnomalyFileNames(projectPath)
        let models = ContentLoader(path: projectPath, fileNames: fileNames).getAnomalyModels()
        let config: String = AnomalyModelMapper().mapToString(models)
        let jsonConfig = SwiftJSONFormatter.beautify(config)
        
        let filename = getPathFor(path: projectPath)?.appendingPathComponent("DynamicAnomalies.json")

        do {
            try jsonConfig.write(to: filename!, atomically: true, encoding: .utf8)
        } catch {
            print(error)
        }
        
        print("SUCCESS")
    } catch {
        print(error.localizedDescription)
    }
}

func getPathFor(path projectPath: String) -> URL? {
    let filePrifix: String = "file://"
    return URL(string: filePrifix + projectPath)
}

start()
