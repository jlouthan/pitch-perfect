//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jennifer Louthan on 10/1/15.
//  Copyright (c) 2015 JennyLouthan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioAtRate(rate: Float) {
        stopAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioAtRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioAtRate(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
    }
    
    
    @IBAction func playReverbAudio(sender: UIButton) {
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var reverbEffect = AVAudioUnitReverb()
//        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset(rawValue: 0)!)
        audioEngine.attachNode(reverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudio()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
