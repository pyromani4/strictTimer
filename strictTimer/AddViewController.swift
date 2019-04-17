//
//  AddViewController.swift
//  strictTimer
//
//  Created by RS on 2019/04/04.
//  Copyright © 2019 RS. All rights reserved.
//

import UIKit

class AddViewController: UIViewController ,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet var pickerView1: UIPickerView!
    @IBOutlet var pickerView2: UIPickerView!
    @IBOutlet var pickerView3: UIPickerView!
    @IBOutlet var pickerView4: UIPickerView!
    @IBOutlet var pickerView5: UIPickerView!

    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var secondIntv: UILabel!
    @IBOutlet var thirdSet: UILabel!
    
    @IBOutlet weak var segmentButton: UISegmentedControl!
    
    var checker = 0
    var datasets: [Int] = []
    
    var time1 = "5"
    var time2 = "5"
    var time3 = "5"
    var time4 = "5"
    var time5 = "5"
    
    var dict: [String:[Int]] = [:]
    
    let dataList = ["5","10","15","20","25","30","35","40","45","50","60","70","75","80","85","90","105","120"]
    let eList = ["15","30","45","60","90","120"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row] + "s"
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        if pickerView.tag == 1 {      // <<<<<<<<<<　変更
            time1 = dataList[row]
            print(time1)
        } else if pickerView.tag == 2 {
            time2 = dataList[row]
        } else if pickerView.tag == 3 {
            time3 = dataList[row]
        } else if pickerView.tag == 4 {
            time4 = dataList[row]
        } else if pickerView.tag == 5 {
            time5 = dataList[row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[Int]]
        }
        
        secondIntv.isHidden = true
        thirdSet.isHidden = true
        pickerView4.isHidden = true
        pickerView5.isHidden = true
        
        pickerView1.tag = 1
        pickerView2.tag = 2
        pickerView3.tag = 3
        pickerView4.tag = 4
        pickerView5.tag = 5
        
        titleField.delegate = self as UITextFieldDelegate
        
        pickerView1.dataSource = self as UIPickerViewDataSource
        pickerView1.delegate = self as UIPickerViewDelegate
        
        pickerView2.dataSource = self as UIPickerViewDataSource
        pickerView2.delegate = self as UIPickerViewDelegate
        
        pickerView3.dataSource = self as UIPickerViewDataSource
        pickerView3.delegate = self as UIPickerViewDelegate
        
        pickerView4.dataSource = self as UIPickerViewDataSource
        pickerView4.delegate = self as UIPickerViewDelegate
        
        pickerView5.dataSource = self as UIPickerViewDataSource
        pickerView5.delegate = self as UIPickerViewDelegate

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        print("here")
        switch sender.selectedSegmentIndex {
        case 0:
            print("here")
            secondIntv.isHidden = true
            thirdSet.isHidden = true
            pickerView4.isHidden = true
            pickerView5.isHidden = true
            checker = 0
        case 1:
            print("here")
            secondIntv.isHidden = false
            thirdSet.isHidden = false
            pickerView4.isHidden = false
            pickerView5.isHidden = false
            checker = 1
        default:
            print("here")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func done(){
        let key = titleField.text
        if titleField.text == ""{
            self.al(title: "null error", message: "type the title!")
        }else{
            if (dict.keys.contains(titleField.text!)){
                self.al(title: "title error", message: "The title is already taken!")
            }else{
                if (checker == 0){
                    print(time1)
                    
                    datasets = [Int(time1)!,Int(time2)!,Int(time3)!]
                    dict[key!] = datasets
                } else{
                    datasets = [Int(time1)!,Int(time2)!,Int(time3)!,Int(time4)!,Int(time5)!]
                    dict[key!] = datasets
                }
                userDefaults.set(dict, forKey: "dict")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func al(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            return
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
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
