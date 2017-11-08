//
//  ViewController.swift
//  ABCproducts
//
//  Created by Maulana Hasbi on 11/8/17.
//  Copyright © 2017 SMK IDN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var no: UILabel!
    @IBOutlet weak var pro: UILabel!
    @IBOutlet weak var mas: UILabel!
    
    var tits: String?
    var nomer:String?
    var produs: String?
    var masa: String?
    

    
    override func viewDidLoad() {
        tit.text = tits!
        no.text = nomer!
        pro.text = produs!
        mas.text = masa!
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

