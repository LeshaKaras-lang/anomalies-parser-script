//
//  FileSaver.swift
//  ConfigProject
//
//  Created by Олексій Карась on 19.06.2024.
//

import Foundation

final class FileSaver {
    
    private enum Constants {
        static let fileName: String = "DynamicAnomalies.json"
    }
    
    private enum Error: Swift.Error {
        case urlIsNil
    }
    
    func saveJsonAsFile(path projectPath: String, json: String) throws {
        guard let url = getPathFor(path: projectPath) else { throw Error.urlIsNil }
        let urlWithFilename = url.appendingPathComponent(Constants.fileName)
        try json.write(to: urlWithFilename, atomically: true, encoding: .utf8)
    }
    
    private func getPathFor(path projectPath: String) -> URL? {
        let filePrifix: String = "file://"
        return URL(string: filePrifix + projectPath)
    }
}
