public extension StringProtocol {
    subscript(_ range: Range<Int>) -> SubSequence {
        let lowerBound = Index(utf16Offset: range.lowerBound, in: self)
        let upperBound = Index(utf16Offset: range.upperBound, in: self)
        return self[lowerBound..<upperBound]
    }

    subscript(_ index: Int) -> SubSequence.Element {
        let index = Index(utf16Offset: index, in: self)
        return self[index]
    }
}
