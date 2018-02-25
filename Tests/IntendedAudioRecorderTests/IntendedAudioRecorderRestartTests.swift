import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder
import AudioIO

class IntendedAudioRecorderRestartTests: XCTestCase {
  
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
            it("should do nothing") {
              
            }
            context("when currently recording") {
              it("should stop recording") {
                
              }
              it("should delete the current recording") {
                
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

