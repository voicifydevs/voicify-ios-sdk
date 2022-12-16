//
//  ViewController.swift
//  voicify-assistant-sample-uikit
//
//  Created by James McCarthy on 12/16/22.
//

import UIKit
import voicify_assistant_sdk

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 200, y: 60, width: 150, height: 50))
        button.backgroundColor = UIColor.blue
        button.setTitle("Open Assistant", for: .normal)
        button.addTarget(self, action: #selector(openAssistantClicked), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func openAssistantClicked(sender: UIButton!){
        print("open assistant")
        
    }
}

