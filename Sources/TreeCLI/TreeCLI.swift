import Foundation
public class TreeCLI {
    var filepaths:[String]?;
    init(filepaths:[String]) {
        self.filepaths = filepaths
    }

    var tree = TreeNode<String>(value: "FileStructure",depth:0,type: .root)
    public func getTree()-> String{
        self.filepaths?.forEach({ (filepath) in
            var foldersandfile = filepath.components(separatedBy: "/")
            var currentNode = self.tree
            var d = 1
            while (foldersandfile.count != 0) {
                let name = foldersandfile.removeFirst()
                if name.contains("."){
                    currentNode.addChild(TreeNode<String>(value: name,depth:d,type: .file))
                }else {
                    currentNode.addChild(TreeNode<String>(value: name,depth:d,type: .folder))
                }
                d += 1
                currentNode = currentNode.getnodewithchildren(name)!
            }
        })

        return self.tree.showtree
    }

}
public enum Treetype {
    case file
    case folder
    case root
}


public class TreeNode<T> {
    public var value: T
    public var depth: Int
    public var type:Treetype
    public weak var parent: TreeNode?
    public var children = [TreeNode<T>]()

    public init(value: T,depth: Int,type:Treetype) {
        self.value = value
        self.depth = depth
        self.type = type
    }

    public func addChild(_ node: TreeNode<T>) {
        children.append(node)
        node.parent = self
    }

}
extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += "\n|\t└" + children.map { $0.description }.joined(separator: "\n├─")
        }
        return s
    }

    public var showtree:String {
        var s:String
        switch self.type {
        case .root:
            s = "\(value)"

        case .folder:
            if self.depth == 1 {
                s = "\n├─\(value)"
            }else {
                s = "\n|"+String(repeating: "\t", count: self.depth-1)+"└\(value)"
            }

        case .file:
            if self.depth == 1 {
                s = "\n├─\(value)"
            }else{
            s = "\n|"+String(repeating: "\t", count: self.depth-1)+"└\(value)"
        }
        }

        if !children.isEmpty {
            s += children.map { $0.showtree }.joined(separator: "") + ""
        }

        return s
    }
}

extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }

    public func getnodewithchildren(_ value:T)-> TreeNode<T>? {
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}

let tree = TreeCLI(filepaths: ["cute/hello/hello.py","maths/maths.py","h.py","klol/lol/hello/h.py"])
print(tree.getTree())
