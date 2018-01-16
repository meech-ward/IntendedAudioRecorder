# Record and Process Audio

1. Record some audio
2. Process the audio to get the _intended_ audio time based on amplitude. The intended audio is the part of the recording that the user intended to be recorded, with things like white noise stripped out from either side. 
3. Return the following audio data:

| AudioData |
|-----------|
|`samples: [AudioSample]`|
|`recomendedStartTime: TimeInterval`|
|`recomendedEndTime: TimeInterval`|

This will depend on:

- AudioRecorder
- AudioProcessor