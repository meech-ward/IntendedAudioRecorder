import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder
import AudioIO

class IntendedAudioRecorderStartTests: XCTestCase {
  
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
          
          it("should have the AmplitudeIntendedAudioProcessor set as its processor") {
            guard ((intendedRecorder.processor as? AmplitudeIntendedAudioProcessor) != nil) else {
              return expect(0).to.fail("recorder has the wrong processor")
            }
            
            expect(0).to.pass()
          }
          
          it("should have an empty samples array") {
            expect(intendedRecorder.samples.count).to.equal(0)
          }
          
          describe("#start") {
            
            var startResult: Bool?
            beforeEach {
              intendedRecorder.start() { flag in
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
            
            it("should have an empty samples array") {
              expect(intendedRecorder.samples.count).to.equal(1)
            }
            
            it("should track the audio samples") {
              timer.timerBlock()
              expect(intendedRecorder.samples.count).to.equal(2)
              timer.timerBlock()
              expect(intendedRecorder.samples.count).to.equal(3)
              timer.timerBlock()
              timer.timerBlock()
              timer.timerBlock()
              expect(intendedRecorder.samples.count).to.equal(6)
            }
            
            
            context("when currently recording") {
              beforeEach {
                startResult = nil
                recordable.started = 0
                intendedRecorder.start() { flag in
                  startResult = flag
                }
                
              }
              it("should un succefull complete") {
                guard let startResult = startResult else {
                  return expect(0).to.fail("stopResult is nil")
                }
                expect(startResult).to.equal(false)
                expect(recordable.started).to.equal(0, "shouldn't have been deleted")
              }
//              it("should stop recording") {
//                
//              }
//              it("should delete the current recording") {
//                
//              }
//              it("should start recording") {
//                
//              }
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
