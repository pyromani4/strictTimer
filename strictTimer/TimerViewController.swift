//
//  TimerViewController.swift
//  strictTimer
//
//  Created by RS on 2019/04/04.
//  Copyright © 2019 RS. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userDefaults = UserDefaults.standard
    
    var audioPlayer = AVAudioPlayer()
    let setSoundID: SystemSoundID = 1306
    let endSoundID: SystemSoundID = 1016
    
    @IBOutlet var dataTableview: UITableView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var sectionLabel: UILabel!
    
    var data: [Int] = []
    var dict: [String:[Int]] = [:]
    var dictKey = ""
    var sectionData = ["1st set","1st intv","2nd set","2nd intv","3rd set"]
    
    var timerRunning = false
    var timer = Timer()
    
    var stopCounter: Int = 0
    var countNum: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        startButton.alpha = 1
        startButton.isEnabled = true
        sectionLabel.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataTableview.dataSource = self as UITableViewDataSource
        dataTableview.delegate = self as UITableViewDelegate
        
        startButton.alpha = 1
        startButton.isEnabled = true
        sectionLabel.text = ""
        timer.invalidate()
        
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[Int]]
        }
        
        if (userDefaults.object(forKey: "key") != nil){
            dictKey = userDefaults.string(forKey: "key")!
        }
        
        
        dataTableview.estimatedRowHeight = 20.0
        dataTableview.rowHeight = UITableViewAutomaticDimension
        dataTableview.isScrollEnabled = false
        
        data = dict[dictKey]!
        
        dataTableview.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath)
        
        var judge = ""
        var count = ""
        // Configure the cell...
        if (indexPath.row == 0){
            judge = "set      "
            count = "1"
        }else if(indexPath.row == 1){
            judge = "interv "
            count = "1"
        }else if(indexPath.row == 2){
            judge = "set      "
            count = "2"
        }else if(indexPath.row == 3){
            judge = "interv "
            count = "2"
        }else if(indexPath.row == 4){
            judge = "set      "
            count = "3"
        }
        cell.textLabel?.text =  count + " " + judge + "    " + String(data[indexPath.row]) + "s"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dict.keys.count == 0 {
            return 0
        }
        return data.count
    }
    

    @IBAction func startTimer(sender : AnyObject) {
        timer = Timer()
        startButton.alpha = 0.4
        startButton.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                        target:self,
                                        selector: #selector(update),
                                        userInfo: nil,
                                        repeats: true)
        timerRunning = true
        
    }
    
    @objc func update(){
        sectionLabel.text = sectionData[stopCounter]
        countNum += 1
        let ms = countNum % 100
        let judger = (countNum - ms) / 100
        if (judger == data[stopCounter]){
            countNum = 0
            stopCounter += 1
            if (stopCounter >= data.count){
                AudioServicesPlaySystemSound(SystemSoundID(1011))
                timer.invalidate()
                stopCounter = 0
                startButton.alpha = 1
                startButton.isEnabled = true
                sectionLabel.text = "Session End"
            }else{
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
        let s = (countNum - ms) / 100 % 60
        let m = (countNum - s - ms) / 6000 % 3600
        countLabel.text = String (format: "%02d:%02d.%02d", m,s,ms)
    }

    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
        timer.invalidate()
    }
    
    @IBAction func edit(){
        timer.invalidate()
        self.performSegue(withIdentifier:"toEdit", sender: nil)
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
