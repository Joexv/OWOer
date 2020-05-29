//
//  TTS.swift
//  
//
//  Created by Joe Oliveira on 5/28/20.
//

import Foundation
import AVFoundation

class TTS {
    
    public func Speak(_ Text: String){
        let synth = AVSpeechSynthesizer()
        var myUtterance = AVSpeechUtterance(string: Text)
    }
}
