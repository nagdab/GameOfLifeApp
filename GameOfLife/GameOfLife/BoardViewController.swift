//
//  BoardViewController.swift
//  GameOfLife
//
//  Created by Bhavik Nagda on 11/17/16.
//  Copyright © 2016 stulinProject. All rights reserved.
//

import Foundation
import UIKit

class BoardViewController: UIViewController {
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        drawer(view: self.view)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let firstFrame = CGRect(x: 0, y: 0, width: 100, height: 150)
//        let firstView = UIView(frame: firstFrame)
//        firstView.backgroundColor = UIColor.blue
//        view.addSubview(firstView)
        
//        print(view.frame.size.height)
        
        drawer(view: view)
    }
    
    func drawer(view: UIView) {
        var c = Colony()
        c.setCellAlive(5, yCoor: 5)
        c.setCellAlive(5, yCoor: 6)
        c.setCellAlive(5, yCoor: 7)
        c.setCellAlive(6, yCoor: 6)
        
        let edge = Double(view.frame.size.width)/60
        
        print(edge)
        print(view.frame.size)
        
        for x in 0...59{
            for y in 0...59{
                let rectFrame = CGRect(x: Double(x) * edge, y: Double(y) * edge, width: edge, height: edge)
                let thisView = UIView(frame: rectFrame)
                thisView.backgroundColor = generateRandomColor()
                view.addSubview(thisView)
            }
        }
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

