//
//  ViewController.swift
//  metronome8
//
//  Created by Louis Kane on 9/8/16.
//  Copyright © 2016 Louis Kane. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = NSTimer()
    
    var soundBPM = 0
    
    @IBOutlet weak var labelBPM: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(sender: AnyObject) {
        
        var currentBPM = Int(slider.value)
        labelBPM.text = "\(currentBPM)"
        soundBPM = (currentBPM / timer )
        
    }
    
    @IBOutlet weak var playButton: UIButton!
    
    var playBPM = 1
    
    var player: AVAudioPlayer!
    
    
    @IBAction func playPressed(sender: AnyObject) {
        
        if let audioPath = NSBundle.mainBundle().pathForResource("Metronome", ofType: "mp3") {
            
            let url = NSURL(fileURLWithPath: audioPath)
            
            do  {
                
                if playBPM == 1 {
                    let sound = try AVAudioPlayer(contentsOfURL: url)
                    player = sound
                    sound.play()
                    sound.numberOfLoops = -1
                    playBPM = 2
                    playButton.setImage(UIImage(named:"pause_Icon.png"),forState:UIControlState.Normal)
                } else {
                    player.pause()
                    playBPM = 1
                    playButton.setImage(UIImage(named:"play_Icon.png"),forState:UIControlState.Normal)
                }
            } catch {
                print(error)
            }
        } else {
            print("nil")
        }

        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector:(Selector("playPressed")), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

