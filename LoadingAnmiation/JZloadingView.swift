//
//  JZJZLoadingView.swift
//  LoadingAnmiation
//
//  Created by Zhang, Jun on 2018/12/27.
//  Copyright © 2018年 Zhang, Jun. All rights reserved.
//

import UIKit
protocol LoadViewProtocol {
  func show()
}
class JZLoadingView: UIView {
  
  private var animationLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 98, height: 98))
    layer.fillColor = nil
    layer.strokeColor = UIColor.blue.cgColor
    layer.lineWidth = 3
    layer.lineCap = CAShapeLayerLineCap.round
    return layer
  }()
  
  var link: CADisplayLink!
  private var startAngle: Double = -.pi / 2
  private var endAngle: Double = -.pi / 2
  
  private var progress: Double = 0.0
  
  class func show(view: UIView) {
    let loadingView = JZLoadingView(frame:view.frame)
    loadingView.render()
    loadingView.start()
    
    view.addSubview(loadingView)
  }
  
  class func hide(view: UIView) {
    _ = view.subviews.map {
      if let loadingView = $0 as? JZLoadingView {
        loadingView.stop()
        $0.removeFromSuperview()
      }
    }
  }
  
  func render() {
    animationLayer.position = CGPoint(x: center.x, y: center.y - 29)
    layer.addSublayer(animationLayer)
    link = CADisplayLink(target: self, selector: #selector(linkAction))
    link.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
    link.isPaused = true
    
  }
  
  func attach(title: String) {
    let label = UILabel()
    let font = UIFont.systemFont(ofSize: 24)
    label.font = font
    label.textAlignment = .center
    label.text = title
    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)
    label.heightAnchor.constraint(equalToConstant: 28).isActive = true
    label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
  }
  
  func start() {
    link.isPaused = false
  }
  
  func stop() {
    link.isPaused = true
    progress = 0.0
  }
  
  
  @objc func linkAction() {
    resetProgressIfNeed()
    updateAnimationLayer()
  }
  
  private func resetProgressIfNeed() {
    let speed = endAngle > Double.pi ? 0.4 / 60 : 1.5 / 60
    progress = progress + speed
    if progress >= 1.0 {
      progress = 0.0
    }
  }
  
  private func updateAnimationLayer() {
    AddStartAngleIfNeed()
    let path = UIBezierPath(arcCenter: CGPoint(x: 49, y: 49), radius: 49, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
    path.lineCapStyle = .round
    animationLayer.path = path.cgPath
  }
  
  private func AddStartAngleIfNeed() {
    startAngle = -.pi / 2
    endAngle = startAngle + progress * Double.pi * 2
    if endAngle > Double.pi {
      animationLayer.lineWidth = 3 * CGFloat(1 - progress)
      animationLayer.opacity = (1 - Float(progress) ) * 1.2
      let progres = -3 + progress * 4
      startAngle = -.pi / 2 + progres * Double.pi * 2
    } else {
      animationLayer.lineWidth = 3
      animationLayer.opacity = 1
      
    }
    
  }
  
}

extension UIViewController {
  
  func show() {
    let  load = JZLoadingView(frame: view.frame)
    load.backgroundColor = UIColor.white
    load.translatesAutoresizingMaskIntoConstraints = false
    load.render()
    load.start()
    view.addSubview(load)
    view.bringSubviewToFront(load)
    view.centreHorizontalFill(childview: load)
    
  }
  
  func hide() {
    _ = view.subviews.map {
      if let loadingView = $0 as? JZLoadingView{
        loadingView.stop()
        loadingView.removeFromSuperview()
      }
    }
  }
  
  func show(title: String) {
    let  load = JZLoadingView(frame: view.frame)
    load.translatesAutoresizingMaskIntoConstraints = false
    load.backgroundColor = UIColor.white
    load.render()
    load.attach(title: title)
    load.start()
    view.addSubview(load)
    view.centreHorizontalFill(childview: load)
  }
  
}

extension UIView {
  func centreHorizontalFill(childview: UIView) {
    childview.translatesAutoresizingMaskIntoConstraints = false
    let views: [String: UIView] = ["childview": childview]
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|-0-[childview]-0-|",
      options: [],
      metrics: nil,
      views: views))
    addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|-0-[childview]-0-|",
      options: [],
      metrics: nil,
      views: views))
  }
  
}
