//
//  ViewController.swift
//  Galaktion Nizharadze, Assignment #17
//
//  Created by Gaga Nizharadze on 18.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redCircle: UIView!
    @IBOutlet weak var blueCircle: UIView!
    @IBOutlet weak var purpleTriangleView: UIView!
    @IBOutlet weak var blackTriangleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTriangle(view: purpleTriangleView, viewColor: .systemPurple)
        self.setUpTriangle(view: blackTriangleView, viewColor: .black)
        
        tapGesture()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeBackgroundColor), name: Notification.Name("com.tbcbootcamp.Galaktion-Nizharadze--Assignment--17.backgroundColorChange"), object: nil)
    }
    
    
    private func setUpTriangle(view: UIView, viewColor: UIColor){
        let heightWidth = view.frame.size.width
        let path = CGMutablePath()
        view.backgroundColor = .clear
        
        path.move(to: CGPoint(x: 0, y: heightWidth))
        path.addLine(to: CGPoint(x:heightWidth / 2, y: heightWidth / 8))
        path.addLine(to: CGPoint(x:heightWidth, y:heightWidth))
        path.addLine(to: CGPoint(x:0, y:heightWidth))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = viewColor.cgColor
        
        view.layer.insertSublayer(shape, at: 0)
    }
    
  
    private func tapGesture() {

        var recognizer: UITapGestureRecognizer {
            get {
                return UITapGestureRecognizer(target: self, action: #selector(tapGetureAction(_ :)))
            }
        }

        redCircle.addGestureRecognizer(recognizer)
        blueCircle.addGestureRecognizer(recognizer)
        purpleTriangleView.addGestureRecognizer(recognizer)
        blackTriangleView.addGestureRecognizer(recognizer)
    }
    
        
    @objc func tapGetureAction(_ sender: UITapGestureRecognizer) {
    
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else { return }
        
        if let tag = sender.view?.tag {
            vc.tag = tag
            print(tag)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeBackgroundColor(notification: Notification) {
        if let color = notification.userInfo?["backgroundColor"] as? UIColor {
            view.backgroundColor = color
        }
        
    }

    
    
}


