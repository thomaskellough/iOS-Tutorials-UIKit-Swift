//
//  ScannerViewController.swift
//  How-To-Scan-A-Barcode
//
//  Created by Thomas Kellough on 8/9/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let torchButton = UIBarButtonItem(title: "Torch", style: .plain, target: self, action: #selector(toggleTorch))
        navigationItem.rightBarButtonItem = torchButton
        
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
        addMetaData()
    }
    
    func addPreviewLayer() {
        avPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avPreviewLayer.frame = view.layer.bounds
        avPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(avPreviewLayer)
    }
    
    @objc func toggleTorch() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if device.torchMode == .on {
                device.torchMode = .off
            } else {
                device.torchMode = .on
            }
            
        } catch {
            print("There was an error trying to use the torch")
        }
    }
    
}

// MARK: Metadata

extension ScannerViewController {
    func addMetaData() {
        let metadataOutput = AVCaptureMetadataOutput()
        
        if avCaptureSession.canAddOutput(metadataOutput) {
            avCaptureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.pdf417]
        } else {
            // Add error message here
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        avCaptureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringObject = readableObject.stringValue else { return }
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            readMetaData(data: stringObject)
        }
        
        navigationController?.popViewController(animated: true)
    }

    func readMetaData(data: String) {
        delegate.updateLabel(text: data)
    }
}
