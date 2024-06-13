//
//  InputHelper.swift
//  ConfigProject
//
//  Created by Олексій Карась on 06.06.2024.
//

import Foundation

struct InputHelper {
    func inputFolder() -> ProjectPath {
        print("\n", "Ваедите путь к папке проекта")
        let projectPath = readLine()
        if var path = projectPath {
            do {
                path = path.trimmingCharacters(in: .whitespaces)
                let fm = FileManager.default
                let objects = try fm.contentsOfDirectory(atPath: path)
                if objects.contains(anomalyConfigFolderName) && objects.contains(anomalyDataFolderName) {
                    return path
                } else {
                    print("\n", "В папке нет \(anomalyConfigFolderName) или \(anomalyDataFolderName)")
                    return inputFolder()
                }
            } catch {
                print("\n", "Не удалось извлечь контент из дериктории")
                return inputFolder()
            }
        } else {
            print("\n", "Не валидный путь")
            return inputFolder()
        }
    }
}
