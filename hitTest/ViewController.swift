//
//  ViewController.swift
//  hitTest
//
//  Created by Ilya Pavlov on 02.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    let viewA = Subview()
    let viewB = PassTouchView()
    let viewC = ExpandedView()
    let viewD = PassTouchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDesign()
        setupConstraints()
        
//        viewD.isUserInteractionEnabled = false
//        viewB.isUserInteractionEnabled = false
    }
    
    private func setupViewDesign() {
        setupContainer(view: viewA, color: .systemGray, cornerRadius: 15)
        setupContainer(view: viewB, color: .systemCyan, cornerRadius: 15)
        setupContainer(view: viewC, color: .systemBlue, cornerRadius: 15)
        setupContainer(view: viewD, color: .clear, cornerRadius: 0)
        viewD.alpha = 0.5
        
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.translatesAutoresizingMaskIntoConstraints = false
        viewC.translatesAutoresizingMaskIntoConstraints = false
        viewD.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(viewA)
        viewA.addSubview(viewB)
        view.addSubview(viewC)
        view.addSubview(viewD)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewA.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            viewA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewA.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            viewA.heightAnchor.constraint(equalToConstant: 300),
            
            viewB.topAnchor.constraint(equalTo: viewA.topAnchor, constant: 100),
            viewB.leadingAnchor.constraint(equalTo: viewA.leadingAnchor, constant: 50),
            viewB.trailingAnchor.constraint(equalTo: viewA.trailingAnchor, constant: -50),
            viewB.heightAnchor.constraint(equalToConstant: 100),
            
            viewC.topAnchor.constraint(equalTo: viewA.bottomAnchor, constant: 200),
            viewC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            viewC.widthAnchor.constraint(equalToConstant: 70),
            viewC.heightAnchor.constraint(equalToConstant: 70),
            
            viewD.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            viewD.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            viewD.widthAnchor.constraint(equalToConstant: view.frame.width),
            viewD.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTouched(tapGestureRecognizer: ))))
        viewA.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewATouched(tapGestureRecognizer: ))))
        viewB.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewBTouched(tapGestureRecognizer: ))))
        viewC.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewCTouched(tapGestureRecognizer: ))))
        viewD.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDTouched(tapGestureRecognizer: ))))
        
    }
    
    @objc func viewTouched(tapGestureRecognizer: UITapGestureRecognizer) {
        print("view was touched")
    }
    
    @objc func viewATouched(tapGestureRecognizer: UITapGestureRecognizer) {
        print("GrayView was touched")
    }
    
    @objc func viewBTouched(tapGestureRecognizer: UITapGestureRecognizer) {
        print("CyanView was touched")
    }
    
    @objc func viewCTouched(tapGestureRecognizer: UITapGestureRecognizer) {
        print("BlueView was touched")
    }
    
    @objc func viewDTouched(tapGestureRecognizer: UITapGestureRecognizer) {
        print("ClearView was touched")
    }
    
    private func setupContainer(view: UIView, color: UIColor, cornerRadius: CGFloat) {
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
    }
    
}

class Subview: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("Subview - Touches began")
    }
}

class ExpandedView: Subview {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -30, dy: -30).contains(point)
    }
}

class PassTouchView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
}
