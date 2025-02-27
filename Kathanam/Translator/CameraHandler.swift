//
//  CameraHandler.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import AVFoundation
import Vision

class CameraHandler: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private var videoOutput = AVCaptureVideoDataOutput()
    
    var onGestureRecognized: ((String) -> Void)?

    override init() {
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        session.sessionPreset = .high
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera) else { return }

        if session.canAddInput(input) { session.addInput(input) }
        if session.canAddOutput(videoOutput) { session.addOutput(videoOutput) }

        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
    }

    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
}

extension CameraHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNDetectHumanHandPoseRequest { request, error in
            guard let results = request.results as? [VNHumanHandPoseObservation], let hand = results.first else {
                return
            }
            
            self.processHandPose(hand)
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
    }

    private func processHandPose(_ observation: VNHumanHandPoseObservation) {
        guard let thumbTip = try? observation.recognizedPoint(.thumbTip),
              let indexTip = try? observation.recognizedPoint(.indexTip),
              let middleTip = try? observation.recognizedPoint(.middleTip),
              let ringTip = try? observation.recognizedPoint(.ringTip),
              let pinkyTip = try? observation.recognizedPoint(.littleTip) else { return }
        
        let gesture = detectGestureLogic(thumbTip: thumbTip, indexTip: indexTip, middleTip: middleTip, ringTip: ringTip, pinkyTip: pinkyTip)
        
        DispatchQueue.main.async {
            self.onGestureRecognized?(gesture)
        }
    }
    
    private func detectGestureLogic(thumbTip: VNRecognizedPoint, indexTip: VNRecognizedPoint, middleTip: VNRecognizedPoint, ringTip: VNRecognizedPoint, pinkyTip: VNRecognizedPoint) -> String {
           
           if thumbTip.y > indexTip.y && thumbTip.y > middleTip.y && thumbTip.y > ringTip.y && thumbTip.y > pinkyTip.y {
               return "Okay 👍"
           }
           
           if indexTip.y < thumbTip.y && middleTip.y < thumbTip.y && ringTip.y < thumbTip.y && pinkyTip.y < thumbTip.y {
               return "Open Hand ✋"
           }
           
           if indexTip.y > thumbTip.y && middleTip.y > thumbTip.y && ringTip.y > thumbTip.y && pinkyTip.y > thumbTip.y {
               return "Fist ✊"
           }
           
           if indexTip.x < thumbTip.x && middleTip.x < thumbTip.x && ringTip.x < thumbTip.x && pinkyTip.x < thumbTip.x {
               return "Waving Hand 👋"
           }
           
           return "Unknown Sign"
       }
}
