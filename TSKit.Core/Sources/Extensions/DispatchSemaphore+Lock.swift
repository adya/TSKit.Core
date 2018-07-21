import Dispatch

extension DispatchSemaphore {

    func inLock<Result>(_ block: () throws -> Result) rethrows -> Result {
        defer { self.signal() }
        self.wait()
        return try block()
    }
}
