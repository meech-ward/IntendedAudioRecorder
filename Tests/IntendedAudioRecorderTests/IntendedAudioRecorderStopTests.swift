import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder
import AudioIO

class IntendedAudioRecorderStopTests: XCTestCase {
  
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
          
          
          
          describe("#end") {
            
            var stopResult: Bool?
            //            var audio: Any?
            
            
            context("when not currently recording") {
              beforeEach {
                intendedRecorder.end() { flag, _ in
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
                intendedRecorder.start(closure: {_ in })
                intendedRecorder.end() { flag, _ in
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
              
              it("should process the audio with the collected samples") {
                let processor = MockAudioProcessor()
                intendedRecorder.processor = processor
                
                func assertProcessingSamples(_ samples: [AudioSample]) {
                  intendedRecorder.samples = samples
                  startAndStop(intendedRecorder: intendedRecorder)
                  expect(intendedRecorder.samples.count).to.equal(processor.samples.count)
                }
                
                assertProcessingSamples([])
                assertProcessingSamples([AudioSample(time: 0)])
                assertProcessingSamples([AudioSample(time: 0), AudioSample(time: 0)])
                assertProcessingSamples([AudioSample(time: 0), AudioSample(time: 0), AudioSample(time: 0), AudioSample(time: 0)])
              }
              
              it("should return the processed audio") {
                
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

