import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder
import AudioIO

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
        and("an amplitude tracker") {
          
          var indendedRecorder: IntendedAudioRecorder!
          var amplitudeTracker: MockAmplitudeTracker!
          var recordable: MockRecordable!
          var timer: MockTimer!
          
          beforeEach {
            recordable = MockRecordable()
            timer = MockTimer()
            amplitudeTracker = MockAmplitudeTracker()
            indendedRecorder = IntendedAudioRecorder(recordable: recordable, amplitudeTracker: amplitudeTracker, timer: timer)
          }
          
          describe("#start") {
            
            var startResult: Bool?
            beforeEach {
              indendedRecorder.start() { flag in
                startResult = flag
              }
            }
            
            it("should start recording") {
              guard let startResult = startResult else {
                return expect(0).to.fail("startResult is nil")
              }
              expect(recordable.started).to.equal(1)
              expect(startResult).to.equal(true)
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
            
            var stopResult: Bool?
//            var audio: Any?
            
            
            context("when not currently recording") {
              beforeEach {
                indendedRecorder.end() { flag, _ in
                  stopResult = flag
//                  audio = result
                }
              }
              
              it("should un succefull complete") {
                guard let stopResult = stopResult else {
                  return expect(0).to.fail("stopResult is nil")
                }
                expect(stopResult).to.equal(false)
              }
              
              it("should not call stop on audio recorder") {
                expect(recordable.stopped).to.equal(0, "stop was called when it shouldn't have been")
              }
            }
            
            
            
            context("when currently recording") {
              beforeEach {
                indendedRecorder.start(closure: {_ in })
                indendedRecorder.end() { flag, _ in
                  stopResult = flag
//                  audio = result
                }
              }
              
              it("should stop recording") {
                guard let stopResult = stopResult else {
                  return expect(0).to.fail("stopResult is nil")
                }
                expect(recordable.stopped).to.equal(1)
                expect(stopResult).to.equal(true)
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
  }
  
  
  static var allTests = [
    ("testSpec", testSpec),
    ]
}
