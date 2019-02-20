//
//  ViewController.swift
//  ReadingApp1
//
//  Created by Tim Shepard on 1/18/19.
//  Copyright © 2019 Tim Shepard. All rights reserved.
//

import UIKit
import Darwin
import AVFoundation
import AudioToolbox
import Speech
import Foundation



class ViewController: UIViewController {
    var trialnoViewOne = String()//number of trials
    var TaskViewOne = String()//trigram or 5 letter word
    var PositionViewOne = String()//location of words on screen 3 options
    var DistanceViewOne = Int()//viewing distance
    var redBackGroundViewOne = Int()
    var greenBackgroundViewOne = Int()
    var blueBackgroundViewOne = Int()
    var redPrintColorViewOne = Int()
    var greenPrintColorViewOne = Int()
    var bluePrintColorViewOne = Int()


    
    //    let grayColor=UIColor(displayP3Red: redBackground/255, green: 128/255, blue: 128/255, alpha: 1)//this is to change background color if needed (e.g. gray background) // This can be used for newer versions of Swift (later than 9.2) The old iPad can only run up to version 9.2.
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var NextTrial: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ////Background color
        let redBackground = CGFloat(self.redBackGroundViewOne)
        let greenBackground = CGFloat(self.greenBackgroundViewOne)
        let blueBackground = CGFloat(self.blueBackgroundViewOne)
        let grayColor=UIColor(displayP3Red: redBackground/255, green: greenBackground/255, blue: blueBackground/255, alpha: 1)//this is to change background color if needed (e.g. gray background) // This can be used for newer versions of Swift (later than 9.2) The old iPad can only run up to version 9.2.
        view.backgroundColor = grayColor // for background color
        
        ////Print Color
        let redPrint = CGFloat(self.redPrintColorViewOne)
        let greenPrint = CGFloat(self.greenPrintColorViewOne)
        let bluePrint = CGFloat(self.bluePrintColorViewOne)

        label.textColor = UIColor(red: redPrint/255, green: greenPrint/255, blue: bluePrint/255, alpha: 1.0)
        
        // self.view.backgroundColor = UIColor.gray //  to change background color in version < 10.0

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        UIScreen.main.brightness = CGFloat(0)
        
        
    }
    
    ////////////////////////////////////////////////////////
    
    ///////////////////////////////////////////////////////////////////////////////////////
    // This will lock the program into landscape mode
    struct AppUtility {
        
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
        
        /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            
            self.lockOrientation(orientation)
            
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.landscape)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    
    var n=1 //initialize counter
    
    
    @IBAction func unwindToTestScreen(_ sender: UIStoryboardSegue){} //this is to go back to the testing screen while saving the variables (e.g. counter="n" Otherwise, the variables are re-initialized every time i come back to this controller).
    
    // observer presses Next Trial button and the trial is inititiated
    @IBAction func Start(_ sender: AnyObject) {
        let methodStart = Date() //timing
        
        var trialno = Int(trialnoViewOne)
        
        
        ////////////////////////////////////////////////////////////
        // this is for the number of trials that we are going to run. The program ends automatically after the last trial
        
        
        if n > trialno! {
            performSegue(withIdentifier: "segue3", sender: nil)//this will segue to the plot data/finish screen
            AudioServicesPlaySystemSound(SystemSoundID(1326))
            //  exit(0)// or can exit program altogether using this
            
        }
        ///////////////////////////////////////////////////////////
        //       Below we will run a trial if the counter (n) is less than or equal to the number of trials requested
        
        if n <= trialno! {
            
            AudioServicesPlaySystemSound(SystemSoundID(1117))
            
            
            //var Task = 2 // change task type here. This will be fed in from the GUI in the future. Word based when task=1; else trigram
            // let Task = SubjectInfoViewController.shared.taskID //type of task is passed from the first view controller
            var Task = Int(TaskViewOne)!
            
            
            switch Task {
                ////////// this is where we select a word from a wordlist (if we are not doing the Trigram task)
                
            case 1:
                var arrayOfStrings: [String]? // this is initializing a var to store all of the words in the list
                
                do {
                    // The text file is in the bundle
                    if let path = Bundle.main.path(forResource: "word05", ofType: "txt"){
                        var data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                        var arrayOfStrings = data.components(separatedBy: "\r")
                        let randomIndex = Int(arc4random_uniform(UInt32((arrayOfStrings.count))))
                        print(arrayOfStrings[randomIndex])
                        // let size = arrayOfStrings.count // count how many words in word list
                        // print(size)
                        // print(arrayOfStrings?[3])
                        //print(arrayOfStrings)
                        label.text = arrayOfStrings[randomIndex]
                        
                    }
                } catch let err as NSError {
                    
                    print(err)
                }
                
                
                
            default:
                //////////
                //HERE IS WHERE WE CONSTRUCT A TRIGRAM
                func randomString(length: Int) -> String {
                    
                    
                    // first lets create a string of all characters including numbers
                    
                    let letters : NSString = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
                    
                    
                    // let letters : NSString = "xxx"//for pilot testing
                    // var letter : NSString = letters.lowercased as NSString // we can also convert all the letters to lowercase. Note is this case we will need to change letters to letter below (redefined)
                    
                    // let no_numbers = letter.components(separatedBy: CharacterSet.decimalDigits).joined() // use this if we would like to exclude numbers
                    
                    
                    let len = UInt32(letters.length)
                    
                    var randomString = ""
                    
                    for _ in 0 ..< length {
                        let rand = arc4random_uniform(len)
                        var nextChar = letters.character(at: Int(rand))
                        randomString += NSString(characters: &nextChar, length: 1) as String
                        
                    }
                    print(randomString)
                    return randomString
                }
                
                label.text=randomString(length:3)
                
            }
            
            /// this is where we are going to have our different positions for stimulus presentation (e.g. center of the screen, random, 9 locations at 10deg eccentricity)
            let Position = Int(PositionViewOne)!
            
            
            switch Position {
                
            case 1: // randomly selected position
                
                do {
                    // position of Text (Label) Here
                    let screenSize = UIScreen.main.bounds
                    print(screenSize)
                    let screenWidth = screenSize.width //- 50 // need to fix...scaling issue between differet iOs devices
                    let screenHeight = screenSize.height //- 50
                    
                    let x_coord:Int = Int(arc4random_uniform(UInt32(Int(screenWidth))))
                    let y_coord:Int = Int(arc4random_uniform(UInt32(Int(screenHeight))))
                    // label.frame.origin = CGPoint(x: x_coord, y: y_coord)// this is used to pick a random location on the
                    label.center = CGPoint(x: x_coord, y: y_coord)//screen. We will be using a list of coordinates in the actual experiment
                }
                
            case 2: // nine positions
                
                
                let xCoords = [256, 512, 768]
                let yCoords = [192, 384, 576]
                
                let randomX = Int(arc4random_uniform(UInt32(xCoords.count)))
                let randomY = Int(arc4random_uniform(UInt32(yCoords.count)))
                
                label.center = CGPoint(x: xCoords[randomX],y: yCoords[randomY])
                // label.frame.origin = CGPoint(x: xCoords[randomX], y: yCoords[randomY])//
                
            default:
                
                do {
                    // position of Text (Label) Center of the screen
                    label.center.y = view.center.y
                    label.center.x = view.center.x
                    
                    
                }
            }
            
            
            
            // size of text
            // let number = arc4random_uniform(60)// pick random number between 20 and 60
            let lowerSize: UInt32 = 10
            let upperSize: UInt32 = 40
            // let number = arc4random_uniform(upperSize - lowerSize) + lowerSize
            let number = 105 ///// there are 52 pixels per cm
            
            let nameFont = "Courier"
            // label.font = UIFont(name: label.font.fontName, size: CGFloat(number)) //apply text size
            label.font = UIFont(name: nameFont, size: CGFloat(number)) //apply text size
            
            //////the letter spacing = 1.16. We also need to center the text in the UITextField as well////
            let xWidth: CGFloat = CGFloat(number)
            let attributedString = NSMutableAttributedString(string: label.text!)
            attributedString.addAttribute(NSKernAttributeName, value: CGFloat(1.16), range: NSMakeRange(0, attributedString.length - 1))
            label.attributedText = attributedString
            
            //
            //////////////////////////////////////////////////////////////////////////////////////
            
            // this is to set up the text converting from visual angle to number of pixels using lookup table
            let screenSize = UIScreen.main.nativeBounds
            print(screenSize)
            let screenWidth = UIScreen.main.nativeBounds.width    // in pixels seems odd the width is shorter than heightdifferent for iPad since it is not normally in lanscape mode
            let screenHeight = UIScreen.main.nativeBounds.height // different for iPad since it is not normally in lanscape mode
            //let viewingDistance: Double = Double(40)//Default in case we would like to change
            let viewingDistance = Double(DistanceViewOne)
            let pixpercmY : Double = Double(screenWidth/19.5)
            let pixpercmX : Double = Double(screenHeight/14.5)
            let eccHorizontal: Double = Double(0)
            let eccVertical: Double = Double(10)
            let pi: Double = Double(M_PI)
            let letterSize: Double = Double(0.6)
            
            // Vertical eccentricity
            let part1Vertical = tan(eccVertical/2/180 * pi) * viewingDistance * 2
            let part2Vertical = part1Vertical * pixpercmY
            let part3Vertical = round(part2Vertical)// round answer
            
            // Horizontal eccentricity
            let part1Horizontal = tan(eccHorizontal/2/180 * pi) * viewingDistance * 2
            let part2Horizontal = part1Horizontal * pixpercmX
            let part3Horizontal = round(part2Horizontal)// round answer
            
            
            // letter size in pixels
            let letterSizePixPart1 = tan(letterSize/2/180 * pi) * viewingDistance * 2
            let letterSizePixPart2 = letterSizePixPart1 * pixpercmY
            let letterSizePixPart3 = round(letterSizePixPart2)// round answer
            
            
            
            ///////////////////////////////////////////////////////////////////////////////
            
            
            // Here is where we are going to turn the stimulus off (change the duration)
            // first write a function to select a random duration between 0 and 1
            // Randomly select a float number between min and max values to be used for duration
            
            
            //func randomDouble(min: Double, max: Double) -> Double {
            //  return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
            //}
            //let duration : Double = Double(randomDouble(min:1,max:3)) // use the function to obtain a random number for the duration
            
            let lowerDuration: UInt32 = 1
            let upperDuration: UInt32 = 4
            //let duration : Double = Double(arc4random_uniform(upperDuration - lowerDuration) + lowerDuration)
            let duration: Double = Double(20)// 10 secs for pilot testing
            
            
            //  stim presentation (take parameters (size, duration, and eccentricity, to present the stimulus)
            
            // mask.frame.origin = CGPoint(x: 315, y: 171)
            // mask.frame.origin = CGPoint(x: x_coord, y: y_coord)// this is for the mask
            
            
            // label.frame.origin = CGPoint(x: x_coord, y: y_coord)// this is used to pick a random location on the screen. We will be using a list of coordinates in the actual experiment
            
            
            //            self.label.isHidden = false //show trigram
            //            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            //                self.label.isHidden = true //hide trigram after duration
            //
            //            }
            //
            
            DispatchQueue.main.asyncAfter(deadline: .now() ,execute: {
                self.label.isHidden = false //show trigram
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.label.isHidden = true //hide trigram after duration
                    
                }
                
                
            })//This is to put a delay in before taking observers response
            
            
           print("Duration: \(duration)")
            
            
            
            
            
            
            
            
            
            /////////////////////////////////////////////
            // enter the observer's response
            //if n<=trialno {
            //performSegue(withIdentifier: "segue4", sender: nil)//this segues to observer response controller
            //}
            /////////////////////////////////////////////
            // Swift.print(content(Bundle.main.resourcePath!+"/temp.bundle/word05.txt"))//Output: testing
            
            // print(n)
            
            //
            
            n=n+1 //add to counter
            
            
        }
        // let methodFinish = NSDate()
        //let executionTime = methodFinish.timeIntervalSince(methodStart)
        // print("Execution time: \(executionTime)")
    }
    
    
    
}







///////////////////// THIS IS WHERE WE ARE GOING TO WRITE TO THE FILE
//let fileName = "TestWeirdName"
//let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)


//let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
//print("FilePath: \(fileURL.path)")

//let writeString = "Write this text to the fileURL as text in iOS using Swift"

//do {
// Write to the file
// try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)

//}
//catch let error as NSError {
//    print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
//}




// THESE ARE NOTES OF THINGS TO INCORPORATE (save a txt file and read to it, radomize trials by duration or size, etc)



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// this is to randomize trials (e.g. a list of durations or screen placement
//let array1 = [20,40,60,80,100,120,140,160,180,200]
//var resultSet = Set<Int>()
//
//while resultSet.count < 10 {
//    let randomIndex = Int(arc4random_uniform(UInt32(array1.count)))
//    resultSet.insert(array1[randomIndex])
//}
//
//let resultArray = Array(resultSet)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// THIS IS TO SAVE TO A FILE. NOTE THE WEIRD FILE DIRECTORY. TO OBTAIN THE FILE, RUN THE FOLLOWING CODE AND THE PASTE THE FILE DIRECTORY INTO THE "GO TO FOLDER"---PRESS CMD-SHIFT-G TO GET TO THE FOLDER. THE TEXT FOLDER SHOULD BE THERE


// Save data to file
//let fileName = "TestWeirdName"
//let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
//print("FilePath: \(fileURL.path)")
//
//let writeString = "Write this text to the fileURL as text in iOS using Swift"
//do {
//    // Write to the file
//    try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
//} catch let error as NSError {
//   print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
//}
//
//var readString = "" // Used to store the file contents
//do {
//    // Read the file contents
//    readString = try String(contentsOf: fileURL)
//} catch let error as NSError {
//    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
//}
//print("File Text: \(readString)")
//
//
//
//
//// Get the document directory url
//let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//do {
//    // Get the directory contents urls (including subfolders urls)
//    let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
//    print(directoryContents)
//
//    // if you want to filter the directory contents you can do like this:
//    let mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
//    print("mp3 urls:",mp3Files)
//    let mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
//    print("mp3 list:", mp3FileNames)
//
//} catch {
//    print(error.localizedDescription)
//}










