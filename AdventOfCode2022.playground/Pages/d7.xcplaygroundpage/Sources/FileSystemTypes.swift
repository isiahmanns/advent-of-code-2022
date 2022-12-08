public protocol FileSystemItem {
    var name: String { get }
    var size: Int { get }
}

public struct File: FileSystemItem {
    public var name: String
    public let size: Int

    public init(name: String, size: Int) {
        self.name = name
        self.size = size
    }
}

public class Folder: FileSystemItem {
    public let name: String
    public var size: Int {
        items
            .map { $0.value.size }
            .reduce(0, +)
    }
    public var items: [String: FileSystemItem] = [:]

    public weak var parent: Folder!
    public static weak var root: Folder!

    public init(name: String, items: [String: FileSystemItem] = [:], isRoot: Bool = false) {
        self.name = name
        self.items = items

        if isRoot {
            self.parent = self
            Folder.root = self
        }
    }
}

public class FileSystem {
    public var folder: Folder

    public init() {
        self.folder = Folder(name: "root", items: [:], isRoot: true)
    }
}

public enum TerminalKeywords: String {
    case cd
    case ls
    case dir
}

