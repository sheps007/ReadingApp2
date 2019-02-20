//
//  MoreSettingsViewController.swift
//  ReadingApp1
//
//  Created by Tim Shepard on 2/7/19.
//  Copyright © 2019 Tim Shepard. All rights reserved.
//

import UIKit




class MoreSettingsViewController: UIViewController {
    

    @IBOutlet weak var viewingDistance: UITextField!//viewing Distance 
    
    @IBOutlet weak var redBackGround: UITextField! // background color R value
    
    @IBOutlet weak var greenBackGround: UITextField!// background color G value
    
    @IBOutlet weak var blueBackGround: UITextField!// background color B value
    
    @IBOutlet weak var redPrintColor: UITextField!//
    
    @IBOutlet weak var greenPrintColor: UITextField!
    
    @IBOutlet weak var bluePrintColor: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray // for background color
        // Do any additional setup after loading the view.

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : SubjectInfoViewController = segue.destination as! SubjectInfoViewController
        DestViewController.viewingDistanceViewOne = viewingDistance.text!
        DestViewController.redBackGroundViewOne = redBackGround.text!
        DestViewController.greenBackGroundViewOne = greenBackGround.text!
        DestViewController.blueBackGroundViewOne = blueBackGround.text!
        DestViewController.redPrintColorViewOne = redPrintColor.text!
        DestViewController.greenPrintColorViewOne = greenPrintColor.text!
        DestViewController.bluePrintColorViewOne = bluePrintColor.text!



    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    
    

}
