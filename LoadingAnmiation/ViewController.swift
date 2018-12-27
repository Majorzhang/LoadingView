//
//  ViewController.swift
//  LoadingAnmiation
//
//  Created by Zhang, Jun on 2018/12/27.
//  Copyright © 2018年 Zhang, Jun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    show()
    
    delay(seconds: 10) { [weak self] in
      self?.hide()
    }
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  private func delay(seconds: TimeInterval, action:  @escaping @convention(block) () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: action)
  
  }


}

