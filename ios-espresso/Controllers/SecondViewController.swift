//
//  SecondViewController.swift
//  ios-espresso
//
//  Created by Aurelio Figueredo on 2022-09-26.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleViewController: UILabel!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleViewController.text = titleString

    }
    
    
}
