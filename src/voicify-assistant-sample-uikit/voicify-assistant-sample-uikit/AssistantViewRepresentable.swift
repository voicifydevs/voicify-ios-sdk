//
//  ViewRepresentable.swift
//  voicify-assistant-sample-uikit
//
//  Created by James McCarthy on 12/18/22.
//

import SwiftUI
import UIKit

struct AssistantViewRepresentable : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> AssistantDrawerViewController {
        let view = AssistantDrawerViewController()
        return view
    }

    func updateUIViewController(_ viewController: AssistantDrawerViewController, context: Context) {
            
    }
}
