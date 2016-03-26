//
//  InfoViewController.swift
//  Osu! Stats
//
//  Created by Michael Justman on 3/7/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
        
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var lbl_pprank: UILabel!
    @IBOutlet weak var lbl_Accuracy: UILabel!
    @IBOutlet weak var lbl_PlayCount: UILabel!
    @IBOutlet weak var lbl_countryrank: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateLabels(){
        lbl_username.text = API_Functions.getUser().username
        lbl_pprank.text = API_Functions.getUser().pp_raw
        lbl_Accuracy.text=API_Functions.getUser().accuracy
        lbl_PlayCount.text=API_Functions.getUser().playcount
        lbl_countryrank.text=API_Functions.getUser().pp_country_rank
        
    }
}
