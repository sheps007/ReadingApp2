//
//  ViewController.swift
//  CalibrationScript
//
//  Created by Tim Shepard on 2/13/19.
//  Copyright © 2019 Tim Shepard. All rights reserved.
//

import UIKit
import Darwin
import AVFoundation
import AudioToolbox
import Speech
import Foundation
import Photos



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var label: UITextField!
    var pointSize = 400
    let iterative = 500
    
    @IBAction func startProgram(_ sender: AnyObject) {
        
 
        // let duration = 50
        //  let iterative = 500
        
        if pointSize >= iterative {
            
            exit(0)// exit program
            
        }
        
        let nameFont = "Courier"
        let letters : NSString = "x"
        if pointSize <= iterative {
            let number = pointSize
            
            label.text = letters as String
            label.font = UIFont(name: nameFont, size: CGFloat(number)) //apply text size
            

            
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let imageTim = UIGraphicsGetImageFromCurrentImageContext()
            UIImageWriteToSavedPhotosAlbum(imageTim!, nil, nil, nil)
            UIGraphicsEndImageContext()


            
            
            // AudioServicesPlaySystemSound(SystemSoundID(1326))
            print(pointSize)
            pointSize = pointSize + 1
        }
        
    }
    
}
