//
//  FullScreenImageViewController.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIImageView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Variables
    
    var image: String = ""
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Animate view and setup image view
        self.setupImageView()
        
        // Setup cross button
        self.setupCrossButton()
        
        // Setup scroll view
        self.setupScrollView()
    }
    
    // MARK: - Setup image view with animation
    
    func setupImageView() {
        UIView.animate(withDuration: 0.4) {
            self.containerView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
            
            self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        // Add pinch to image view
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
//        self.containerView.isUserInteractionEnabled = true
//        self.containerView.addGestureRecognizer(pinchGesture)
        
        // Set image to image view
        self.containerView.sd_setImage(with: URL(string: self.image), placeholderImage: UIImage(named: CommonStrings.placehodlerImage))
    }
    
    // MARK: - Setup cross button
    
    func setupCrossButton() {
        self.crossButton.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        self.crossButton.layer.cornerRadius = self.crossButton.frame.width / 2
    }
    
    // MARK: - Setup scroll view
    
    func setupScrollView() {
        // Set the initial zoom scale and properties
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.zoomScale = 1.0
        
        // Enable scrolling and zooming
        scrollView.isScrollEnabled = true
        scrollView.bouncesZoom = true
        scrollView.bounces = true
    }
    
    // MARK: - Button Actions
    
    @IBAction func crossButtonTapped(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        self.containerView.window?.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Gesture Recognizer Actions
    
    @objc func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}

extension FullScreenImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.containerView
    }
}
