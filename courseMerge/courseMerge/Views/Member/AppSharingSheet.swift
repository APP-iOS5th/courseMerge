//
//  AppSharingSheet.swift
//  CourseMerge
//
//  Created by Heeji Jung on 6/11/24.
//

import SwiftUI

public struct AppSharingSheet: UIViewControllerRepresentable{
    @Binding var isPresented: Bool
    public let activityItems: [Any]
    public let appActivites: [UIActivity]? = nil
    
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        UIViewController()
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: appActivites
        )
        if isPresented && uiViewController.presentedViewController == nil {
            uiViewController.present(activityViewController, animated: true)
        }
        activityViewController.completionWithItemsHandler = {(_,_,_,_) in
            isPresented = false
        }
        
    }
}

