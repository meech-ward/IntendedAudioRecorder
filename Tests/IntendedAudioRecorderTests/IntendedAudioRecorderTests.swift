import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder


class IntendedAudioRecorderTests: XCTestCase {
  
  override class func setUp() {
    let reporter = Reporter.sharedInstance
    reporter.failBlock = XCTFail
    Focus.set(reporter: reporter)
    Observe.set(reporter: reporter)
  }
  
  func testSpec() {
    describe("IntendedAudioRecorder") {
      when("initialized with an audio recorder") {
        
        var indendedRecorder: IntendedAudioRecorder!
        beforeEach {
//            IntendedAudioRecorder(recorder: {MockRecorder()})
        }
        
        describe("#start") {
          it("should start recording") {
            
          }
          
          context("when currently recording") {
            it("should stop recording") {
              
            }
            it("should delete the current recording") {
              
            }
            it("should start recording") {
              
            }
          }
        }
        
        describe("#end") {
          context("when currently recording") {
            it("should stop recording") {
              
            }
            it("should process the audio") {
              
            }
            it("should return the processed audio") {
              
            }
          }
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
  
  
  static var allTests = [
    ("testSpec", testSpec),
    ]
}
