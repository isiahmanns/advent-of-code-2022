import Foundation

class Solution {

    lazy var fileSystem: FileSystem = {
        var fileSystem = FileSystem()
        populate(folder: fileSystem.folder, with: cleanData)
        return fileSystem
    }()

    lazy var cleanData: [[Substring]] = {
        return clean(data: getData())
    }()

    private func getData() -> String {
        guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
              let data = try? String.init(contentsOfFile: path) else {
            fatalError()
        }

        return data
    }

    private func clean(data: String) -> [[Substring]] {
        return data
            .split(separator: "\n")
            .map { cmd in
                cmd.split(separator: " ")
            }
    }

    private func createFileSystemItemsIfNeeded(currentFolder: Folder,
                                               output: [[Substring]],
                                               currentLineIdx: Int) -> Int {
        var lineIdx = currentLineIdx + 1
        var line = output[lineIdx]
        var prefix = line[0]

        repeat {
            defer {
                lineIdx += 1
                if lineIdx < output.count {
                    line = output[lineIdx]
                    prefix = line[0]
                }
            }

            switch prefix {
            case TerminalKeywords.dir.rawValue:
                let folderName = String(line[1])
                guard currentFolder.items[folderName] == nil else { continue }

                let folder = Folder(name: folderName)
                folder.parent = currentFolder
                currentFolder.items[folderName] = folder
            default:
                let fileName = String(line[1])
                guard currentFolder.items[fileName] == nil else { continue }

                guard let fileSize = Int(line[0]) else { fatalError() }
                let file = File(name: fileName, size: fileSize)
                currentFolder.items[fileName] = file
            }
        } while (lineIdx < output.count && prefix != "$")

        return lineIdx
    }

    private func getFolder(for folderName: String, in currentFolder: Folder) -> Folder {
        switch folderName {
        case "/":
            return Folder.root
        case "..":
            return currentFolder.parent
        default:
            guard let folder = currentFolder.items[String(folderName)] as? Folder
            else { fatalError() }
            return folder
        }
    }

    private func populate(folder: Folder, with data: [[Substring]]) {
        var currentFolder = folder

        let output = data
        var lineIdx = 0
        while lineIdx < output.count {
            let line = output[lineIdx]
            let prefix = line[0]
            let cmd = line[1]

            assert(prefix == "$")

            switch cmd {
            case TerminalKeywords.cd.rawValue:
                //print("cd", line)
                let folderName = String(line[2])
                currentFolder = getFolder(for: folderName, in: currentFolder)
            case TerminalKeywords.ls.rawValue:
                //print("ls", line)
                let nextCmdIdx = createFileSystemItemsIfNeeded(
                    currentFolder: currentFolder,
                    output: output,
                    currentLineIdx: lineIdx)
                lineIdx = nextCmdIdx - 1
            default:
                fatalError()
            }

            lineIdx += 1
        }
    }

    private func sumDirsBroken(in folder: Folder, with sizeLimit: Int) -> Int {
        var sum = 0

        // TODO: - swiftbug??? can only evaluate one of these conditions at a time
        let validFolders = folder.items.values.filter({ $0 is Folder && $0.size <= sizeLimit })
        print(validFolders)
        for item in validFolders {
            print(item.name)
            sum += item.size + sumDirsBroken(in: item as! Folder, with: sizeLimit)
        }

        return sum
    }

    private func sumDirs(in folder: Folder, limit sizeLimit: Int) -> Int {
        var sum = 0

        for item in folder.items.values where item is Folder {
            // print(item.name)
            let size = item.size
            sum += (size <= sizeLimit ? size : 0) + sumDirs(in: item as! Folder, limit: sizeLimit)
        }

        return sum
    }

    private func getFolders(in folder: Folder) -> [Folder] {
        var sumFolders: [Folder] = []

        for item in folder.items.values where item is Folder {
            let item = item as! Folder
            sumFolders += [item] + getFolders(in: item)
        }

        return sumFolders
    }

    func runP1() -> Int {
        return sumDirs(in: fileSystem.folder, limit: 100_000)
    }

    func runP2() -> Int {
        let availableDiskSpace = 70_000_000
        let requiredFreeSpace = 30_000_000

        let totalUsedSpace = fileSystem.folder.size
        let availableFreeSpace = availableDiskSpace - totalUsedSpace
        let minDeleteSpace = requiredFreeSpace - availableFreeSpace

        return getFolders(in: fileSystem.folder)
            .sorted(by: {$0.size < $1.size})
            .first(where: {$0.size >= minDeleteSpace})?.size ?? -1
    }
}

let solution = Solution()
solution.runP1()
solution.runP2()
