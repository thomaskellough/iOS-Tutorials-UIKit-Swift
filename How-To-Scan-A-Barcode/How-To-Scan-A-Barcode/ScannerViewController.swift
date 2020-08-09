//
//  ScannerViewController.swift
//  How-To-Scan-A-Barcode
//
//  Created by Thomas Kellough on 8/9/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController {

    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpScanner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if avCaptureSession?.isRunning == true {
            avCaptureSession.stopRunning()
        }
    }
    
    func setUpScanner() {
        avCaptureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if avCaptureSession.canAddInput(videoInput) {
                avCaptureSession.addInput(videoInput)
            } else {
                // Add error message here
                return
            }
        } catch {
            // Add error message here
            return
        }
        
        avCaptureSession.startRunning()
        addPreviewLayer()
    }
    
    func addPreviewLayer() {
        avPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avPreviewLayer.frame = view.layer.bounds
        avPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(avPreviewLayer)
    }
    
}
