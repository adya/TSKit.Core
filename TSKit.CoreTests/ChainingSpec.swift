import Quick
import Nimble
@testable import TSKit_Core

class ChainingSpec: QuickSpec {
    
    override func spec() {
        describe("Composition operator") {
            var steps: [Int] = []
            var composition: (() -> Void)!
            beforeEach {
                steps = []
                composition = { steps.append(0) } => { steps.append(1) }
            }
            it("should not be executed when composing") {
                expect(steps).to(beEmpty())
            }
            it("should execute functions in the same order") {
                composition()
                expect(steps).to(equal([0,1]))
            }
        }
    }
}
