import AVFoundation
import UIKit
import Vision

@available(iOS 13.0, *)
@objc(CameraManager) class CameraManager: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool { return true }
  
  @objc func sayHello(_ name: String) {
    print("Hello \(name)")
  }
  
  @objc func requestCameraPermission(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
      if granted {
        resolve(true)
      } else {
        reject("PERMISSION_DENIED", "Camera permission denied", nil)
      }
    })
  }
  
  @objc func openCamera(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
        reject("NO_ROOT_VIEW_CONTROLLER", "Unable to find root view controller", nil)
        return
      }
      guard let rootViewController = keyWindow.rootViewController else {
        reject("NO_ROOT_VIEW_CONTROLLER", "Unable to find root view controller", nil)
        return
      }
      
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        rootViewController.present(imagePickerController, animated: true, completion: nil)
        resolve(true)
      } else {
        reject("CAMERA_NOT_AVAILABLE", "Camera not available", nil)
      }
    }
  }
  @objc func toggleFlash(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      guard let device = AVCaptureDevice.default(for: .video) else {
        reject("NO_CAMERA_DEVICE", "Unable to find camera device", nil)
        return
      }
      
      if device.hasTorch {
        do {
          try device.lockForConfiguration()
          if device.torchMode == .on {
            device.torchMode = .off
          } else {
            try device.setTorchModeOn(level: 1.0)
          }
          device.unlockForConfiguration()
          resolve(device.torchMode == .on)
        } catch {
          reject("TOGGLE_FLASH_FAILED", "Failed to toggle flash", error)
        }
      } else {
        reject("NO_FLASH_AVAILABLE", "No flash available on this device", nil)
      }
    }
  }
}
