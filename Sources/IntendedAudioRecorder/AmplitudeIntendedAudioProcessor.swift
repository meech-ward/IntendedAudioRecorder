//
//  AmplitudeIntendedAudioProcessor.swift
//  IntendedAudioRecorderPackageDescription
//
//  Created by Sam Meech-Ward on 2018-02-24.
//

import Foundation
import AudioIO
import AudioProcessor

struct AmplitudeIntendedAudioProcessor: AmplitudeIntendedAudioProcessorType {
  
  func processIntendedAudioBasedOnAmplitude(samples: [AudioSample]) throws -> AudioTimeData {
    let processor = AudioProcessor(samples: samples)
    let data = try processor.processBasedOnAmplitude()
    return data
  }
  
  
}
