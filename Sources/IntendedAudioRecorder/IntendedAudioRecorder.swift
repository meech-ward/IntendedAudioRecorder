import AudioIO

class IntendedAudioRecorder {
  
  var recorder: AudioRecorder!
  var processor: AmplitudeIntendedAudioProcessorType = AmplitudeIntendedAudioProcessor()
  var samples = [AudioSample]()
  
  init(recordable: AudioRecordable, amplitudeTracker: AudioAmplitudeTrackerType, timer: TimerType
    ) {
    self.recorder = AudioRecorder(recordable: recordable, powerTracker: nil, frequencyTracker: nil, amplitudeTracker: amplitudeTracker, dataTimer: timer, dataClosure: { sample, recordable in
      self.samples.append(sample)
    })
  }
  
  func start(closure: @escaping ((Bool) -> ())) {
    samples = [AudioSample]()
    recorder.start(closure: closure)
  }
  
  func end(closure: @escaping ((Bool, AudioTimeData?) -> ())) {
    guard recorder.isRecording else  {
      closure(false, nil)
      return
    }
    
    recorder.stop() { flag in
      let audioTimeData = try? self.processor.processIntendedAudioBasedOnAmplitude(samples: self.samples)
      closure(flag, audioTimeData)
    }
  }
  
  func delete(closure: @escaping ((Bool) -> ())) {
    guard recorder.isRecording else  {
      closure(false)
      return
    }
    
    recorder.stop() { flag in
      
      guard flag == true else {
        closure(false)
        return
      }
      
      self.recorder.delete { flag in
        closure(flag)
      }
    }
  }
}
