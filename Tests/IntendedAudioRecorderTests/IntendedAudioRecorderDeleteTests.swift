import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder
import AudioIO

class IntendedAudioRecorderDeleteTests: XCTestCase {
  
  override class func setUp() {
    let reporter = Reporter.sharedInstance
    reporter.failBlock = XCTFail
    Focus.set(reporter: reporter)
    Observe.set(reporter: reporter)
  }
  
  func testSpec() {
    describe("IntendedAudioRecorder") {
      
      func startAndStop(intendedRecorder: IntendedAudioRecorder) {
        intendedRecorder.start(closure: {_ in })
        intendedRecorder.end(closure: {_,_  in })
      }
      
      when("initialized with an audio recorder") {
        and("an amplitude tracker") {
          
          var intendedRecorder: IntendedAudioRecorder!
          var amplitudeTracker: MockAmplitudeTracker!
          var recordable: MockRecordable!
          var timer: MockTimer!
          
          beforeEach {
            recordable = MockRecordable()
            timer = MockTimer()
            amplitudeTracker = MockAmplitudeTracker()
            intendedRecorder = IntendedAudioRecorder(recordable: recordable, amplitudeTracker: amplitudeTracker, timer: timer)
          }
          
          describe("#delete") {
            
            var deleteResult: Bool?
            var closureCallCount = 0
            func deleteRecorder() {
              closureCallCount = 0
              intendedRecorder.delete() { flag in
                deleteResult = flag
                closureCallCount += 1
              }
            }
            
            func expectDeleteResult(_ result: Bool) {
              guard let deleteResult = deleteResult else {
                return expect(0).to.fail("stopResult is nil")
              }
              expect(deleteResult).to.equal(result)
            }
            
            it("should un succefull complete") {
              deleteRecorder()
              expectDeleteResult(false)
              expect(recordable.deleted).to.equal(0, "shouldn't have been deleted")
            }
            
            context("when currently recording") {
              
              beforeEach {
                intendedRecorder.start(closure: {_ in})
                deleteRecorder()
              }
              
              it("should stop recording") {
                expect(recordable.stopped).to.equal(1, "should have been stopped")
              }
              
              it("should delete the current recording") {
                expect(recordable.deleted).to.equal(1, "should have been stopped")
              }
              it("should pass in the delete flag from the recordable") {
                recordable.deleteClosureFlag = false
                intendedRecorder.start(closure: {_ in})
                deleteRecorder()
                expectDeleteResult(recordable.deleteClosureFlag)
                recordable.deleteClosureFlag = true
                intendedRecorder.start(closure: {_ in})
                deleteRecorder()
                expectDeleteResult(recordable.deleteClosureFlag)
              }
              
              context("when stopping fails") {
                
                beforeEach {
                  recordable.deleted = 0
                  intendedRecorder.start(closure: {_ in})
                  recordable.stopClosureFlag = false
                  deleteRecorder()
                }
               
                it("delete should fail") {
                  expectDeleteResult(false)
                }

                it("delete should not get excuted") {
                  expect(recordable.deleted).to.equal(0, "shouldn't have been deleted")
                }
                
              }
            }
            
            context("when stopped recording") {
              it("should delete the current recording") {
                
              }
            }
          }
        }
      }
    }
  }
  
  
  static var allTests = [
    ("testSpec", testSpec),
    ]
}

