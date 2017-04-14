//
//  ViewController.swift
//  EZAudio-Swift
//
//  Created by Syed Haris Ali on 7/9/15.
//  Copyright (c) 2015 Syed Haris Ali. All rights reserved.
//

import UIKit



class ViewController: UIViewController, EZMicrophoneDelegate {

    //------------------------------------------------------------------------------
    // MARK: Properties
    //------------------------------------------------------------------------------
    
    @IBOutlet weak var plot: EZAudioPlotGL!
    var microphone: EZMicrophone!
    
    //------------------------------------------------------------------------------
    // MARK: Status Bar Style
    //------------------------------------------------------------------------------
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    
    //------------------------------------------------------------------------------
    // MARK: View Lifecycle
    //------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        microphone = EZMicrophone(delegate: self, startsImmediately: true);
    }
    
    //------------------------------------------------------------------------------
    // MARK: Actions
    //------------------------------------------------------------------------------
    
    @IBAction func changedPlotType(_ sender: UISegmentedControl) {
        let plotType: EZPlotType = EZPlotType(rawValue: sender.selectedSegmentIndex)!;
        plot.plotType = plotType;
        switch plotType {
        case EZPlotType.buffer:
            plot.shouldFill = false;
            plot.shouldMirror = false;
            break;
        case EZPlotType.rolling:
            plot.shouldFill = true;
            plot.shouldMirror = true;
            break;

        }
    }

    //------------------------------------------------------------------------------
    // MARK: EZMicrophoneDelegate
    //------------------------------------------------------------------------------

    func microphone(_ microphone: EZMicrophone!, hasAudioReceived buffer: UnsafeMutablePointer<UnsafeMutablePointer<Float>?>!, withBufferSize bufferSize: UInt32, withNumberOfChannels numberOfChannels: UInt32) {
        DispatchQueue.main.async(execute: { [unowned self] () -> Void in
            self.plot.updateBuffer(buffer[0], withBufferSize: bufferSize);
        });
    }
    
    
}

