//
//  FrontCamera.swift
//  demo
//
//  Created by KrishnanMuthiahPillai on 21/07/22.
//

import ARKit
import AVFoundation

class FrontCamera: NSObject {
  lazy var session: AVCaptureSession = .init()

  lazy var device: AVCaptureDevice = AVCaptureDevice.default(
    .builtInWideAngleCamera, for: .video, position: .front)!

  lazy var input: AVCaptureDeviceInput = try! AVCaptureDeviceInput(device: device)

  lazy var output: AVCaptureVideoDataOutput = .init()

  override init() {
    super.init()
     
    output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
    session.addInput(input)
      session.addOutput(output)
  }

  func setSampleBufferDelegate(_ delegate: AVCaptureVideoDataOutputSampleBufferDelegate) {

    output.setSampleBufferDelegate(delegate, queue: .main)
  }

  func start() {
    session.startRunning()
      
  }

  func stop() {
    session.stopRunning()
  }
}
