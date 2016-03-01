//
//  ViewController.swift
//  AnimationDemo
//
//  Created by JSHENG on 16/2/27.
//  Copyright © 2016年 JSHENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    var animationLayer = PRTransformLayer()
    
    var layer1 : PRTransformLayer!
    var layer2 : PRTransformLayer!
    var layer3 : PRTransformLayer!
    var layer4 : PRTransformLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addAnimationLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnimationLayer() {
        layer1 = PRTransformLayer()
        layer1.progress = 0
        layer1.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer1.backgroundColor = UIColor.redColor().CGColor
        animationView.layer.addSublayer(layer1)
        
        layer2 = PRTransformLayer()
        layer2.frame = CGRect(x: 100, y: 0, width: 100, height: 100)
        layer2.backgroundColor = UIColor.orangeColor().CGColor
        animationView.layer.addSublayer(layer2)
        
        layer3 = PRTransformLayer()
        layer3.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        layer3.backgroundColor = UIColor.blueColor().CGColor
        animationView.layer.addSublayer(layer3)
        
        layer4 = PRTransformLayer()
        layer4.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        layer4.backgroundColor = UIColor.greenColor().CGColor
        animationView.layer.addSublayer(layer4)
        animationView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
    }

    @IBAction func startAnimationAction(sender: UIButton) {
        // reset
        animationLayer.removeAllAnimations()
        layer1.removeAllAnimations()
        layer2.removeAllAnimations()
        layer3.removeAllAnimations()
        layer4.removeAllAnimations()

        animationView.layer.addAnimation(rotationAnimation(), forKey: nil)
        
        layer1.addAnimation(circleAnimation(), forKey: "progress")
        layer1.progress = 1
        layer2.addAnimation(circleAnimation(), forKey: "progress")
        layer3.addAnimation(circleAnimation(), forKey: "progress")
        layer4.addAnimation(circleAnimation(), forKey: "progress")
    }
    
    
    func circleAnimation()-> CAAnimationGroup {
        
        let progressAnimation = CABasicAnimation(keyPath: "progress")
        progressAnimation.toValue = 4;
        progressAnimation.autoreverses = false
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0.6
        scaleAnimation.autoreverses = true
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = 0
        animation.toValue = 50
        animation.autoreverses = true
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI_4
        rotationAnimation.autoreverses = true
        rotationAnimation.repeatCount = HUGE
        
        let group = CAAnimationGroup()
        group.duration = 0.6
        group.autoreverses = true
        group.repeatCount = HUGE
        group.animations = [progressAnimation, scaleAnimation, animation, rotationAnimation]
        return group
    }

    func rotationAnimation()-> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = M_PI_2+M_PI_4
        animation.duration = 1.2
        animation.repeatCount = HUGE
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animation
    }
}

