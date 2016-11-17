//
//  manager.swift
//  GameOfLife
//
//  Created by John Barbone on 11/17/16.
//  Copyright © 2016 stulinProject. All rights reserved.
//

import Foundation

class manager{
    var colonies : [String : colony] = ["default": colony(), "glider gun": colony()] //add templates
    var active : colony = colony()
    
    init(){
        // add all templates, create them below
        //eventually read this from disk
        
    }
    
    func addColony(name: String){
        colonies[name] = colony()
    }
    
    func removeColony(name: String){
        colonies.removeValue(forKey: name)
    }
    
    
}
