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
  func start(closure: @escaping ((Bool) -> ())) {
    closure(true)
    started += 1
    isRecording = true
  }
  var stopped = 0
  func stop(closure: @escaping ((Bool) -> ())) {
    closure(true)
    stopped += 1
    isRecording = false
  }
  var deleted = 0
  func delete(closure: @escaping ((Bool) -> ())) {
    closure(true)
    deleted += 1
    isRecording = false
  }
  
  var currentTime: TimeInterval = 0
  
  var isRecording: Bool = false
}

class MockAmplitudeTracker: AudioAmplitudeTrackerType {
  var amplitude: Double? = 0
  
  var rightAmplitude: Double?
  
  var leftAmplitude: Double?
}

class MockAudioProcessor: AmplitudeIntendedAudioProcessorType {
  var samples = [AudioSample]()
  var audioTimeData = AudioTimeData(startTime: 0, endTime: 0)
  func processIntendedAudioBasedOnAmplitude(samples: [AudioSample]) throws -> AudioTimeData {
    self.samples = samples
    return audioTimeData
  }
}
