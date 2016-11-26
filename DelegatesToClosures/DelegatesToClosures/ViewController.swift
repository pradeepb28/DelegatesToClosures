//
//  ViewController.swift
//  DelegatesToClosures
//
//  Created by pradeep burugu on 11/26/16.
//  Copyright © 2016 pradeep burugu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let speech: PBSpeechRecognizer = PBSpeechRecognizer(localeString: "en_US",
               checkAvailability: { isAvailable in
                print("isAvailable:\(isAvailable)")
                
            }, requestAuthorizationStatus: { status in
                print("requestAuthorizationStatus:\(status)")
                
            },availabilityDidChange: { speechRecognizer, available in
                print("availabilityDidChange")
                
            }, speechRecognitionDetection: { task in
                print("speechRecognitionDetection")
                
            }, speechRecongitionFinish: { task, result in
                print("speechRecongitionFinish")
                
            }, speechRecognitionCancelled: { task in
                print("speechRecognitionCancelled")
                
            }, speechRecognitionHypothesizeTranscription: { task, transcription in
                print("speechRecognitionHypothesizeTranscription")
                
            }, speechRecognitionFinishedReadingAudio: { task in
                print("speechRecognitionFinishedReadingAudio")
                
            }, speechRecognitionFinishSuccessfully: { task, successfully in
                print("speechRecognitionFinishSuccessfully")
            }
            
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

