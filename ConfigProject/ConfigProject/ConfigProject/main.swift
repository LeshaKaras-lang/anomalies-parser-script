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
        let models: [AnomalyModel] = ContentLoader(path: projectPath, fileNames: fileNames).getAnomalyModels()
        let json: String = AnomalyModelMapper().mapToJson(models)
        let beautifyJson: String = SwiftJSONFormatter.beautify(json)
        try FileSaver().saveJsonAsFile(path: projectPath, json: beautifyJson)
        print("SUCCESS")
    } catch {
        print(error.localizedDescription)
    }
}

start()
