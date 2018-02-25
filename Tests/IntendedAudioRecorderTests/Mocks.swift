//
//  Mocks.swift
//  IntendedAudioRecorderPackageDescription
//
//  Created by Sam Meech-Ward on 2018-02-24.
//

import Foundation
@testable import IntendedAudioRecorder
import AudioIO
import AudioProcessor

class MockTimer: TimerType {
  var timerBlock: () -> (Void) = {}
  func start(_ block: @escaping () -> (Void)) {
    timerBlock = block
  }
  
  func stop() {
    
  }
}

class MockRecordable: AudioRecordable {
  var started = 0
  var startClosureFlag = true
  func start(closure: @escaping ((Bool) -> ())) {
    started += 1
    isRecording = true
    closure(startClosureFlag)
  }
  var stopped = 0
  var stopClosureFlag = true
  func stop(closure: @escaping ((Bool) -> ())) {
    stopped += 1
    isRecording = false
    closure(stopClosureFlag)
  }
  var deleted = 0
  var deleteClosureFlag = true
  func delete(closure: @escaping ((Bool) -> ())) {
    deleted += 1
    isRecording = false
    closure(deleteClosureFlag)
  }
  
  var currentTime: TimeInterval = 0
  
  var isRecording: Bool = false
}

class MockAmplitudeTracker: AudioAmplitudeTrackerType {
  var amplitude: Double? = 0
  
  var rightAmplitude: Double?
  
  var leftAmplitude: Double?
}

enum MockError: Error {
  case error
}

class MockAudioProcessor: AmplitudeIntendedAudioProcessorType {
  var samples = [AudioSample]()
  var audioTimeData = AudioTimeData(startTime: 0, endTime: 0)
  
  var willThrow = false
  
  
  func processIntendedAudioBasedOnAmplitude(samples: [AudioSample]) throws -> AudioTimeData {
    if willThrow {
      throw MockError.error
    }
    self.samples = samples
    return audioTimeData
  }
}
