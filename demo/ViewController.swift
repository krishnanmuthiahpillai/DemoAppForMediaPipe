//
//  ViewController.swift
//  demo
//
//  Created by KrishnanMuthiahPillai on 21/07/22.
//

import AVFoundation
import SceneKit
import UIKit
import FaceMeshIOSLibFramework
import Vision

class ViewController: UIViewController,FaceMeshIOSLibDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    let camera = FrontCamera()
      let displayLayer: AVSampleBufferDisplayLayer = .init()
      let ffind: FaceMeshIOSLib = FaceMeshIOSLib()!

    @IBOutlet weak var cameraview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraview.layer.addSublayer(displayLayer)
          camera.setSampleBufferDelegate(self)
          camera.start()
          ffind.startGraph()
          ffind.delegate = self
    }

    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       displayLayer.frame = cameraview.bounds
     }

     func captureOutput(
       _ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer,
       from connection: AVCaptureConnection
     ) {
       connection.videoOrientation = AVCaptureVideoOrientation.portrait
         connection.isVideoMirrored = true
       displayLayer.enqueue(sampleBuffer)
       let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
       ffind.processVideoFrame(pixelBuffer)
     }
    
    func didReceiveFaces(_ faces: [[FaceMeshIOSLibFaceLandmarkPoint]]!) {
        if let faces = faces,!faces.isEmpty{
            
            for facelandmarks in faces {
              
                if !facelandmarks.isEmpty {
                    for landmarks in facelandmarks {
                        print("face", landmarks.x)
                        print("face", landmarks.y)
                        print("face", landmarks.z)
                    }
                }
            }
            
        }
    }
    
    func didReceiveFaceBoxes(_ faces: [FaceMeshIOSLibNormalizedRect]!) {
        
        if let faces = faces,!faces.isEmpty{
            print(faces[0].height)
            print(faces[0].width)
            print(faces[0].centerX)
            print(faces[0].centerY)
            print(faces[0].rotation)
        }
        
   
    }
}

