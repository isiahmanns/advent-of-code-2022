/**
 using nil to distinguish between a file and a folder isn't ok
 because a file and folder have different property lists
 better to create separate type for each enum case, see File/Folder implemenation
 */
class FileSystemClassNode {
    var name: String = "defaultname"
    var size: Int?
    var files: [FileSystemClassNode]?
}
enum FileSystemEnumNode {
    case file(name: String, size: Int)
    indirect case folder(name: String, files: [FileSystemEnumNode])
}

/**
using nil to distinguish between a leaf and a nonleaf works here
they both share the same list of properties (same for linkedlist node)
*/
class TreeClassNode {
    var value: Int = 0
    var left: TreeClassNode?
    var right: TreeClassNode?
}
enum TreeEnumNode {
    case leaf(value: Int)
    indirect case nonleaf(value: Int, left: TreeEnumNode, right: TreeEnumNode)
}
