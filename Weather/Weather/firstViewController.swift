//
//  firstViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/11.
//

import UIKit

class firstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "toMain", sender: nil)
    }
    
}



