import AudioIO

struct IntendedAudioRecorder {
  
  let recorder: AudioRecorder
  var processor: AmplitudeIntendedAudioProcessorType?
  
  init(recordable: AudioRecordable, amplitudeTracker: AudioAmplitudeTrackerType, timer: TimerType
    ) {
    self.recorder = AudioRecorder(recordable: recordable, powerTracker: nil, frequencyTracker: nil, amplitudeTracker: amplitudeTracker, dataTimer: timer, dataClosure:nil)
  }
  
  func data(_ sample: AudioSample, recordable: AudioRecordable) {
    
  }
  
  func start(closure: @escaping ((Bool) -> ())) {
    recorder.start(closure: closure)
  }
  
  func end(closure: @escaping ((Bool, Any?) -> ())) {
    guard recorder.isRecording else  {
      closure(false, nil)
      return
    }
    
    recorder.stop() { flag in 
      closure(flag, 0)
    }
  }
  
}
