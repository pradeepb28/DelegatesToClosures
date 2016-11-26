//
//  PBSpeechRecognizer.swift
//  DelegatesToClosures
//
//  Created by pradeep burugu on 11/26/16.
//  Copyright © 2016 pradeep burugu. All rights reserved.
//

import UIKit
import Speech

class SpeechRecognizer: SFSpeechRecognizer, SFSpeechRecognitionTaskDelegate, SFSpeechRecognizerDelegate {
    
    private var availabilityDidChange                      : (SFSpeechRecognizer, Bool) -> ()?
    private var speechRecognitionDetection                 : (SFSpeechRecognitionTask) -> ()?
    private var speechRecognitionCancelled                 : (SFSpeechRecognitionTask) -> ()?
    private var speechRecongitionFinish                    : (SFSpeechRecognitionTask, SFSpeechRecognitionResult) -> ()?
    private var speechRecognitionHypothesizeTranscription  : (SFSpeechRecognitionTask, SFTranscription) -> ()?
    private var speechRecognitionFinishedReadingAudio      : (SFSpeechRecognitionTask) -> ()?
    private var speechRecognitionFinishSuccessfully        : (SFSpeechRecognitionTask, Bool) -> ()?
    
    init(locale: Locale,
         checkAvailability: @escaping (Bool) -> (),
         requestAuthorizationStatus: @escaping (SFSpeechRecognizerAuthorizationStatus) -> (),
         availabilityDidChange: @escaping (SFSpeechRecognizer, Bool) -> (),
         speechRecognitionDetection: @escaping (SFSpeechRecognitionTask) -> (),
         speechRecongitionFinish: @escaping (SFSpeechRecognitionTask, SFSpeechRecognitionResult) -> (),
         speechRecognitionCancelled: @escaping (SFSpeechRecognitionTask) -> (),
         speechRecognitionHypothesizeTranscription: @escaping (SFSpeechRecognitionTask, SFTranscription) -> (),
         speechRecognitionFinishedReadingAudio: @escaping (SFSpeechRecognitionTask) -> (),
         speechRecognitionFinishSuccessfully: @escaping (SFSpeechRecognitionTask, Bool) -> ()
        ) {
        self.availabilityDidChange                      = availabilityDidChange
        self.speechRecognitionDetection                 = speechRecognitionDetection
        self.speechRecongitionFinish                    = speechRecongitionFinish
        self.speechRecognitionCancelled                 = speechRecognitionCancelled
        self.speechRecognitionHypothesizeTranscription  = speechRecognitionHypothesizeTranscription
        self.speechRecognitionFinishedReadingAudio      = speechRecognitionFinishedReadingAudio
        self.speechRecognitionFinishSuccessfully        = speechRecognitionFinishSuccessfully
        super.init(locale: locale)!
        
        delegate = self
        
        checkAvailability(isAvailable)
        
        SpeechRecognizer.requestAuthorization { (status) in
            requestAuthorizationStatus(status)
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        availabilityDidChange(speechRecognizer, available)
    }
    
    func speechRecognitionDidDetectSpeech(_ task: SFSpeechRecognitionTask) {
        speechRecognitionDetection(task)
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        speechRecongitionFinish(task, recognitionResult)
    }
    
    func speechRecognitionTaskWasCancelled(_ task: SFSpeechRecognitionTask) {
        speechRecognitionCancelled(task)
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didHypothesizeTranscription transcription: SFTranscription) {
        speechRecognitionHypothesizeTranscription(task, transcription)
    }
    
    func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
        speechRecognitionFinishedReadingAudio(task)
    }
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        speechRecognitionFinishSuccessfully(task, successfully)
    }
    
}

