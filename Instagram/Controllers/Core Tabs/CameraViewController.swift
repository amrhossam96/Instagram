//
//  CameraViewController.swift
//  Instagram
//
//  Created by Amr Hossam on 15/07/2021.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    
    var imageView: UIImageView?
    var pickedMediaView: UIImageView?
    
    
    let cancelEditButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    let toggleCameraButton: UIButton = {
       
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "arrow.triangle.swap", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()

    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 8
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let cancelCapturingButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let pickMediaButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)
        let image = UIImage(systemName: "photo", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height-120)
        cancelCapturingButton.frame = CGRect(x: view.width-90, y: view.safeAreaInsets.top, width: 90, height: 90)
        cancelEditButton.frame = CGRect(x: view.width-90, y: view.safeAreaInsets.top, width: 90, height: 90)
        toggleCameraButton.frame = CGRect(x: view.width-90, y: view.height - 200, width: 90, height: 90)
        pickMediaButton.frame = CGRect(x: 2, y: view.height - 200, width: 90, height: 90)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(pickMediaButton)
        checkCameraPermissions()
        view.addSubview(toggleCameraButton)
        shutterButton.addTarget(self,
                                action: #selector(didTapTakePicture),
                                for: .touchUpInside)
        tabBarController?.tabBar.isHidden = true
        view.addSubview(cancelCapturingButton)
        view.addSubview(cancelEditButton)
        cancelCapturingButton.addTarget(self,
                                        action: #selector(didTapCancelCapturingButton),
                                        for: .touchUpInside)
        
        cancelEditButton.addTarget(self,
                                        action: #selector(didTapCancelEditButton),
                                        for: .touchUpInside)
        pickMediaButton.addTarget(self,
                                  action: #selector(didTapPickMediaButton),
                                  for: .touchUpInside)
        toggleCameraButton.addTarget(self,
                                     action: #selector(didTapToggleCameraButton),
                                     for: .touchUpInside)
        
    }
    
    
    
    @objc private func didTapPickMediaButton() {
        previewLayer.isHidden = true
        session?.stopRunning()
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc private func didTapCancelEditButton() {
        cancelEditButton.isHidden = true
        session?.startRunning()
        cancelCapturingButton.isHidden = false
        shutterButton.isHidden = false
        pickMediaButton.isHidden = false
        toggleCameraButton.isHidden = false
        pickedMediaView?.image = nil
        pickMediaButton.isHidden = false
        previewLayer.isHidden = false
    }
    
    @objc private func didTapCancelCapturingButton() {
        tabBarController?.selectedIndex = 0
        session?.stopRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previewLayer.isHidden = false
        tabBarController?.tabBar.isHidden = true
        cancelCapturingButton.isHidden = false
        cancelEditButton.isHidden = true
        pickMediaButton.isHidden = false
        toggleCameraButton.isHidden = false
        shutterButton.isHidden = false
        session?.startRunning()
    }
    
    @objc private func didTapToggleCameraButton() {


    }
    
    private func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                session.startRunning()
                
                self.session = session
                
            } catch {
                print(error)
            }
        }
    }
    
    private func checkCameraPermissions() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setupCamera()
        @unknown default:
            break
        }
        
    }
    
    @objc private func didTapTakePicture(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        cancelCapturingButton.isHidden = true
        cancelEditButton.isHidden = false
        shutterButton.isHidden = true
        pickMediaButton.isHidden = true
        toggleCameraButton.isHidden = true
    }

}


extension CameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image = UIImage(data: data)
        session?.stopRunning()
        guard var imageView = imageView else {return}
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        view.addSubview(imageView)
    }
}


extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        session?.stopRunning()
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {


            let vc = PostEditorViewController()
            vc.originalImage = image
            vc.modalPresentationStyle = .fullScreen
            picker.dismiss(animated: true, completion: nil)
            present(vc, animated: true, completion: nil)
           
          
        }
        cancelCapturingButton.isHidden = true
        cancelEditButton.isHidden = true
        pickMediaButton.isHidden = true
        toggleCameraButton.isHidden = true
        shutterButton.isHidden = true
        

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
   
}
