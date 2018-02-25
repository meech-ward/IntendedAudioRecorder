//
//  ProcessedAudio.swift
//  IntendedAudioRecorderTests
//
//  Created by Sam Meech-Ward on 2018-02-24.
//
import AudioIO
import Foundation

public struct ProcessedAudio {
  let samples: [AudioSample]
  let intendedTimeData: AudioTimeData
  
  public init(samples: [AudioSample], intendedTimeData: AudioTimeData) {
    self.samples = samples
    self.intendedTimeData = intendedTimeData
  }
}
