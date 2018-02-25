//
//  AudioRecordingTests.swift
//  IntendedAudioRecorderTests
//
//  Created by Sam Meech-Ward on 2018-02-24.
//

import XCTest
import Observe
import Focus
import CleanReporter

@testable import IntendedAudioRecorder

class AudioRecordingTests: XCTestCase {
  
  override class func setUp() {
    let reporter = Reporter.sharedInstance
    reporter.failBlock = XCTFail
    Focus.set(reporter: reporter)
    Observe.set(reporter: reporter)
  }
  
  func testSpec() {
    describe("IntendedAudioRecorder") {
      
      describe("#adjust") {
        it("should adjust the start and end amount by that much") {
//          expect(false).to.be.true()
        }
      }
    }
  }
  static var allTests = [
    ("testSpec", testSpec),
    ]
}
