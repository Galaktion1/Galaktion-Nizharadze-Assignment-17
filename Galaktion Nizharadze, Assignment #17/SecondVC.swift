//
//  SecondVC.swift
//  Galaktion Nizharadze, Assignment #17
//
//  Created by Gaga Nizharadze on 19.07.22.
//

import UIKit

class SecondVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainImage: UIImageView!
    
    var tag: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagSwitch()
        // Do any additional setup after loading the view.
    }
    
    private func tagSwitch() {
        switch tag {
        case 0:
            longPress()
        case 1:
            longPress()
        case 2:
            swipeGesture()
        case 3:
            pinchGesture()
            
        default:
            print("Hmmm")
        }
    }
    
    private func longPress() {
        
        var gesture = UILongPressGestureRecognizer()
        
        if tag == 0 {
            gesture = UILongPressGestureRecognizer(target: self, action: #selector(firstCirclelongPressAction(_ :)))
        }
        
        else {
            gesture = UILongPressGestureRecognizer(target: self, action: #selector(secondCirclelongPressAction(_ :)))
        }
        
        
        gesture.minimumPressDuration = 1.0
        gesture.delaysTouchesBegan = true
        gesture.delegate = self

        mainImage.addGestureRecognizer(gesture)
    }
    
    @objc func firstCirclelongPressAction(_ gesture: UIGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func secondCirclelongPressAction(_ gesture: UIGestureRecognizer) {
        UIView.transition(with: mainImage, duration: 0.15,
                          options: .transitionFlipFromTop,
                          animations: nil,
                          completion: {_ in
            self.mainImage.isHidden = true
        })
    }
    
    
    func swipeGesture() {
       
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        rightSwipeGesture.direction = .right
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        leftSwipeGesture.direction = .left
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        downSwipeGesture.direction = .down
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        upSwipeGesture.direction = .up
        
        mainImage.addGestureRecognizer(rightSwipeGesture)
        mainImage.addGestureRecognizer(leftSwipeGesture)
        mainImage.addGestureRecognizer(downSwipeGesture)
        mainImage.addGestureRecognizer(upSwipeGesture)
        
    }
    

    @objc func swipeGestureAction(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:   moveMainImage(x: -50, y: 0)
        case .right:  moveMainImage(x: 50, y: 0)
        case .up:     moveMainImage(x: 0, y: -50)
        case .down:   moveMainImage(x: 0, y: 50)
        default:      print("other")
        }
    }
    
    
    
    private func moveMainImage(x: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options:[], animations: {
            self.mainImage.transform = CGAffineTransform(translationX: x, y: y)
            }, completion: nil)
    }
    
    
    
    func pinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        mainImage.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinched(gesture: UIPinchGestureRecognizer) {
        print("zoom")
        gesture.view?.transform = (gesture.view?.transform.scaledBy(x: gesture.scale, y: gesture.scale))!
        print(gesture.scale)
        gesture.scale = 1
        
        if (!view.superview!.bounds.contains(mainImage.frame))
        {
            mainImage.transform = CGAffineTransform.identity
            NotificationCenter.default.post(name: Notification.Name("com.tbcbootcamp.Galaktion-Nizharadze--Assignment--17.backgroundColorChange"), object: 5, userInfo: ["backgroundColor" : UIColor.random()])

        }
    }
}
    


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}
