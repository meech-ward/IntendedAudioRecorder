import AudioIO

public class IntendedAudioRecorder {
  
  public var recorder: AudioRecorder!
  public var processor: AmplitudeIntendedAudioProcessorType = AmplitudeIntendedAudioProcessor()
  public var samples = [AudioSample]()
  
  public init(recordable: AudioRecordable, amplitudeTracker: AudioAmplitudeTrackerType, timer: TimerType
    ) {
    self.recorder = AudioRecorder(recordable: recordable, powerTracker: nil, frequencyTracker: nil, amplitudeTracker: amplitudeTracker, dataTimer: timer, dataClosure: { sample, recordable in
      self.samples.append(sample)
    })
  }
  
  public func start(closure: @escaping ((Bool) -> ())) {
    guard recorder.isRecording == false else  {
      closure(false)
      return
    }
    
    samples = [AudioSample]()
    recorder.start(closure: closure)
  }
  
  public func end(closure: @escaping ((Bool, ProcessedAudio?) -> ())) {
    guard recorder.isRecording else  {
      closure(false, nil)
      return
    }
    
    recorder.stop() { flag in
      do {
        let audioTimeData = try self.processor.processIntendedAudioBasedOnAmplitude(samples: self.samples)
        let processedAudio = ProcessedAudio(samples: self.samples, intendedTimeData: audioTimeData)
        closure(flag, processedAudio)
      } catch {
        closure(false, nil)
      }
    }
  }
  
  public func delete(closure: @escaping ((Bool) -> ())) {
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
