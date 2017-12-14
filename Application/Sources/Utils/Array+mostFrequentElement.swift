import Foundation

extension Array {
    var mostFrequentElement: Element? {
        let countedSet = NSCountedSet(array: self)
        guard let mostFrequent = (countedSet.max { countedSet.count(for: $0) < countedSet.count(for: $1) } as? Element) else { return nil }
        return mostFrequent
    }
}
