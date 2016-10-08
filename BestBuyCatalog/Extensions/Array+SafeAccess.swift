import Foundation

extension Array {
    func get(index: Int) -> Element? {
        guard index < count else {
            return nil
        }

        return self[index]
    }
}
