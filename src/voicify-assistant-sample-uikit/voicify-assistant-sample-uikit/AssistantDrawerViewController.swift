//
//  ViewController.swift
//  voicify-assistant-sample-uikit
//
//  Created by James McCarthy on 12/16/22.
//

import UIKit
import SwiftUI
import voicify_assistant_sdk

class AssistantDrawerViewController: UIViewController {
    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var nowPlayingLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Now Playing"
        label.textColor = .black
        label.tag = 100
        return label
    }()
    
    lazy var openAssistantButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Open Assistant", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(openAssistantClicked), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpLayout()
        view.backgroundColor = UIColor.white
        contentStack.addArrangedSubview(nowPlayingLabel)
        contentStack.addArrangedSubview(openAssistantButton)
        view.addSubview(contentStack)
    }
    
    
    @objc func openAssistantClicked(sender: UIButton!){
        NotificationCenter.default.post(Notification(name: Notification.Name("openAssistant")))
    }
}

