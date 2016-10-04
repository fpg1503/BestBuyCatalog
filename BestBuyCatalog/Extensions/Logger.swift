import Foundation

private func abortIfNotTesting() {
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
        abort()
    }
}

func logFailedPrecondition(_ message: String,
                           file: String = #file,
                           line: Int = #line) {
    #if DEBUG
        print("precondition failed at \(file):\(line): \(message)")
        abortIfNotTesting()
    #else
        //TODO: Consider logging to crashlytics/other service
    #endif
}
