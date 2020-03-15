//: [Previous](@previous)

import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        button.center = view.center
        button.setTitle("click me", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func click() {
        
        if view.backgroundColor == .yellow {
            view.backgroundColor = .blue
        } else {
            view.backgroundColor = .yellow
        }
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController.view

//: [Next](@next)
