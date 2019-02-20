//
//  SubjectInfoViewController.swift
//  ReadingApp1
//
//  Created by Tim Shepard on 1/23/19.
//  Copyright © 2019 Tim Shepard. All rights reserved.
//

import UIKit



class SubjectInfoViewController: UIViewController, UITextFieldDelegate {
    
    var viewingDistanceViewOne = String()
    var redBackGroundViewOne = String()
    var greenBackGroundViewOne = String()
    var blueBackGroundViewOne = String()
    var redPrintColorViewOne = String()
    var greenPrintColorViewOne = String()
    var bluePrintColorViewOne = String()



    static let shared: SubjectInfoViewController=SubjectInfoViewController()// this is implemented to share information from this viewController to other ViewControllers
    
    
    @IBAction func toMoreSettings(_ sender: AnyObject) {
    }
    

    
    //let grayColor=UIColor(displayP3Red: 128/255, green: 128/255, blue: 128/255, alpha: 1)//this is to change background color if needed (e.g. gray background)// this can be used for version 10.0 and above. The old iPad is version 9.2 and cannot be updated
    
    @IBOutlet weak var subjectID: UITextField! //subjectID field
    
    @IBOutlet weak var numberOfTrials: UITextField! // number of trials
    
    @IBOutlet weak var Task: UITextField!//this is the type of task 1= word-based from a text file. Else= trigram task
    
    @IBOutlet weak var myTextField: UITextField! //this is to make the keyboard disappear when we press enter in the last text box Note that UITextFieldDelegate has been added to the class Note: This is ann Outlet button that is connect to the last text box in the stack (e.g. letter spacing)
    
    @IBOutlet weak var Position: UITextField! // this is the number of positions: 1=random 2=center (FILL IN OTHERS AS WE ADD THEM)
    
    @IBAction func saveSetupParams(_ sender: UIButton) {
        let saveSubjectIDInput: String = self.subjectID.text!
        let saveNumberOfTrialsInput = (self.numberOfTrials.text! as NSString).integerValue
        let saveTaskTypeInput = (self.Task.text! as NSString).integerValue
        
        
      
        
     
        
//        print(saveSubjectIDInput)
//        print(saveNumberOfTrialsInput)
//        print(saveTaskTypeInput)
        
        //// Another way to share information to new controller//////////
        //SubjectInfoViewController.shared.taskID = taskID
        //SubjectInfoViewController.shared.trialNo = trialNo
        //SubjectInfoViewController.shared.myTrials = myTrials
        /////////////////////////////////////////////////////////////////
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view.backgroundColor = grayColor // for background color
        self.view.backgroundColor = UIColor.gray // for background color
        
        self.myTextField.delegate = self //this setting up to make the keyboard disappear when we press enter in the last text box
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true //this function will make the keyboard disappear when "Done" is pressed in the last text box
    }
    
    /////////////////////////////////////////////////////////////////////////////////
    //we are passing variables from the first controller SubjectInfo to the main ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : ViewController = segue.destination as! ViewController
        DestViewController.trialnoViewOne = numberOfTrials.text!
        DestViewController.TaskViewOne = Task.text!
        DestViewController.PositionViewOne = Position.text!
        ///here we are passing data onto ViewController within the same function
        let distance = Int(viewingDistanceViewOne)!
        DestViewController.DistanceViewOne = distance
        
        ///Pass on Background color onto ViewController
        let redBackgroundColor = Int(redBackGroundViewOne)!
        DestViewController.redBackGroundViewOne = redBackgroundColor
        let greenBackgroundColor = Int(greenBackGroundViewOne)!
        DestViewController.greenBackgroundViewOne = greenBackgroundColor
        let blueBackgroundColor = Int(blueBackGroundViewOne)!
        DestViewController.blueBackgroundViewOne = blueBackgroundColor
        
        ///Pass on Print color to ViewController
        let redPrint = Int(redPrintColorViewOne)!
        DestViewController.redPrintColorViewOne = redPrint
        let greenPrint = Int(greenPrintColorViewOne)!
        DestViewController.greenPrintColorViewOne = greenPrint
        let bluePrint = Int(bluePrintColorViewOne)!
        DestViewController.bluePrintColorViewOne = bluePrint
        
        
        


        
    }
    

}
