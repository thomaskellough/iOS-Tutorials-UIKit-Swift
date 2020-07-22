//
//  ScannerViewController.swift
//  How-To-Scan-A-Barcode
//
//  Created by Thomas Kellough on 7/21/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    
    weak var delegate: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if avCaptureSession?.isRunning == false {
            avCaptureSession.startRunning()
        }
        
        setUpScanner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if avCaptureSession?.isRunning == true {
            avCaptureSession.stopRunning()
        }
    }
}

// MARK: AVCaptureSession
extension ScannerViewController {
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
        
        addMetaData()
        addPreviewLayer()
        showScanBounds()
        
        avCaptureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        self.configureVideoOrientation()
    }
    
    func configureVideoOrientation() {
        if let previewLayer = avPreviewLayer, let connection = previewLayer.connection {
            let orientation = UIDevice.current.orientation

            if connection.isVideoOrientationSupported,
                let videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) {
                previewLayer.frame = self.view.bounds
                connection.videoOrientation = videoOrientation
                showScanBounds()
            }
        }
    }
    
    func addPreviewLayer() {
        avPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avPreviewLayer.frame = view.layer.bounds
        avPreviewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(avPreviewLayer)
    }
    
    func showScanBounds() {
        if avPreviewLayer.sublayers?.count == 3 {
            avPreviewLayer.sublayers?.remove(at: 2)
        }

        let rectangle = UIBezierPath(rect: CGRect(x: 8, y: (view.bounds.size.height / 2) + 30, width: view.bounds.size.width - 16, height: 60))
        let boundLayer = CAShapeLayer.init()
        boundLayer.path = rectangle.cgPath
        boundLayer.fillColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1).cgColor
        boundLayer.strokeColor = UIColor.green.cgColor
        avPreviewLayer.addSublayer(boundLayer)
    }
}

// MARK: AVCaptureMetaData
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
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
        delegate.updateLabel(with: data)
    }
    
}

