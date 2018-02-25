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
            var audioData: AudioTimeData?
            var stopClosureCallCount = 0
            func endRecorder() {
              stopClosureCallCount = 0
              intendedRecorder.end() { flag, result in
                stopResult = flag
                stopClosureCallCount += 1
                audioData = result
              }
            }
            func startAndStopRecorder() {
              intendedRecorder.start(closure: {_ in })
              endRecorder()
            }
            
            context("when not currently recording") {
              beforeEach {
                endRecorder()
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
              
              it("should only call the end closure once") {
                expect(stopClosureCallCount).to.equal(1, "end closure called too many times \(stopClosureCallCount)")
              }
            }
            
            context("when currently recording") {
              beforeEach {
                startAndStopRecorder()
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
                  startAndStopRecorder()
                  expect(intendedRecorder.samples.count).to.equal(processor.samples.count)
                }
                
                assertProcessingSamples([])
                assertProcessingSamples([AudioSample(time: 0)])
                assertProcessingSamples([AudioSample(time: 0), AudioSample(time: 0)])
                assertProcessingSamples([AudioSample(time: 0), AudioSample(time: 0), AudioSample(time: 0), AudioSample(time: 0)])
              }
              
              it("should return the processed audio") {
                let processor = MockAudioProcessor()
                intendedRecorder.processor = processor
                
                func assertRecorderReturnsProcessorTimeData() {
                  startAndStopRecorder()
                  expect(audioData == nil).to.be.false("audio data is nil")
                  expect(audioData!).to.equal(processor.audioTimeData)
                }
                assertRecorderReturnsProcessorTimeData()
                
                processor.audioTimeData = AudioTimeData(startTime: 1, endTime: 0)
                assertRecorderReturnsProcessorTimeData()
                
                processor.audioTimeData = AudioTimeData(startTime: 0, endTime: 1)
                assertRecorderReturnsProcessorTimeData()
                
                processor.audioTimeData = AudioTimeData(startTime: 42.77, endTime: 987.456)
                assertRecorderReturnsProcessorTimeData()
              }
              
              it("should only call the end closure once") {
                expect(stopClosureCallCount).to.equal(1, "end closure called too many times \(stopClosureCallCount)")
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

