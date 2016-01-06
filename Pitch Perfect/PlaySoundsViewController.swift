//
//  PlaySoundsViewController.swift
//  AudioSlave
//
//  Created by Eduardo Prats on 1/3/16.
//  Copyright © 2016 edprats. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var stopPlayButton: UIButton!
    
    var receivedAudio: RecordedAudio!
    var audioPlayer = AVAudioPlayer()
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Play Sounds"
        stopPlayButton.enabled = false

        audioEngine = AVAudioEngine()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
            audioPlayer.enableRate = true
            
        } catch {
            print("No sound found that matches")
        }
        
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio() {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        stopPlayButton.enabled = true
    }
    
    @IBAction func stopPlaybackButtonPressed(sender: UIButton) {
        audioPlayer.stop()
        stopPlayButton.enabled = false
    }
    
    @IBAction func slowPlayButtonPressed(sender: UIButton) {
        audioPlayer.rate = 0.5
        playAudio()
    }

    @IBAction func fastPlayButtonPressed(sender: UIButton) {
        audioPlayer.rate = 1.5
        playAudio()
    }
    
    @IBAction func chipmunkPlayButtonPressed(sender: UIButton) {
       playWithChangedPitch(1000)
    }
    
    @IBAction func darthVaderPlayButtonPressed(sender: UIButton) {
        playWithChangedPitch(-1000)
    }
    
    func playWithChangedPitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
        stopPlayButton.enabled = true
    }
}
