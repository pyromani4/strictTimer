//
//  ViewController.swift
//  strictTimer
//
//  Created by RS on 2019/04/04.
//  Copyright © 2019 RS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var titleTableview: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    var dict: [String:[Int]] = [:]
    var keyList: [String] = []
    var dictKey = ""
    
    override func viewWillAppear(_ animated: Bool) {
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[Int]]
            keyList = Array(dict.keys)
            print(keyList)
        }
        
        titleTableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTableview.dataSource = self as UITableViewDataSource
        titleTableview.delegate = self as UITableViewDelegate
        
        // Do any additional setup after loading the view.
        titleTableview.reloadData()
        
        if (userDefaults.object(forKey: "dict") != nil){
            dict = userDefaults.object(forKey: "dict")! as! [String:[Int]]
            keyList = Array(dict.keys).sorted()
            print(keyList)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = keyList[indexPath.row] 
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dict.keys.count == 0 {
            return 0
        }
        return dict.keys.count
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        dictKey = keyList[indexPath.row]
        userDefaults.set(dictKey, forKey: "key")
        let targetViewController = self.storyboard!.instantiateViewController(withIdentifier: "Timer")
        self.present(targetViewController, animated: true, completion: nil)
    }

}

