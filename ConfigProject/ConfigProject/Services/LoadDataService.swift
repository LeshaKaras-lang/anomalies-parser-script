//
//  LoadDataService.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

struct LoadDataService {
    
    enum Error: Swift.Error {
        case fileNotFound(name: String)
        case emptyFold(name: String)
    }
    
    static func loadAnomalyFileNames(_ folderPath: String) throws -> [String] {
        let fm = FileManager.default
        let folders: [String] = try fm.contentsOfDirectory(atPath: folderPath)
        guard let anomalyConfigFolder: String = folders.first(where: { $0 == anomalyConfigFolderName }) else {
            throw Error.fileNotFound(name: anomalyConfigFolderName)
        }
        
        let searchPath = folderPath + "/\(anomalyConfigFolder)"
        do {
            let alllFiles = try fm.contentsOfDirectory(atPath: searchPath)
            let jsonFiles: [String] = alllFiles.filter { $0.hasSuffix(".json") }
            return jsonFiles
        } catch {
            throw Error.emptyFold(name: anomalyConfigFolder)
        }
    }
}
