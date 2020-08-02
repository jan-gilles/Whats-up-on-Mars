//
//  ImageZoomView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 08.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import UIKit

class ImageZoomView: UIScrollView {
    
    var imageView: UIImageView!
    var gestureRecognizer: UITapGestureRecognizer!
    
    convenience init(frame: CGRect, image: UIImage) {
        self.init(frame: frame)
        
        imageView = UIImageView(image: image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        setupScrollView()
        setupTapGestureRecognizer()
    }
    
    
    func setupScrollView() {
        delegate = self
        
        minimumZoomScale = 1.0
        maximumZoomScale = 10.0
    }
    
    func setupTapGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func didDoubleTap() {
        if zoomScale <= 1.2 {
            zoom(to: zoomRect(withCenter: gestureRecognizer.location(in: gestureRecognizer.view), scale: 3.0), animated: true)
        } else {
            setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomRect(withCenter center: CGPoint, scale: CGFloat) -> CGRect {
        let width = imageView.frame.size.height / scale
        let height = imageView.frame.size.width / scale
        
        let newCenter = convert(center, from: imageView)
        let originX = newCenter.x - (width / 2)
        let originY = newCenter.y - (height / 2)
        
        let size = CGSize(width: width, height: height)
        let origin = CGPoint(x: originX, y: originY)
        
        return CGRect(origin: origin, size: size)
        
    }
    
}


extension ImageZoomView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
