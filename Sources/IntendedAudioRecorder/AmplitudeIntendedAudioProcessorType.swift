//
//  File.swift
//  IntendedAudioRecorderPackageDescription
//
//  Created by Sam Meech-Ward on 2018-02-24.
//

import Foundation
import AudioIO

public protocol AmplitudeIntendedAudioProcessorType {
  func processIntendedAudioBasedOnAmplitude(samples: [AudioSample]) throws -> AudioTimeData
}
