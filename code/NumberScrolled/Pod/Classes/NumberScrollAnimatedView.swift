//
//  NumberScrollAnimatedView.swift
//  Pods
//
//  Created by tanghaibo on 16/3/24.
//
//

import Cocoa

class NumberScrollAnimatedView: UIView {
    //TODO:if change these properties, should update the corresponding view
    var textColor: UIColor      //color of number
    var textFont: UIFont        //font of number
    
    //change this property not effet the runing animation
    var duration: Float         //whole animation duration
    var durationOffset: Float   //next animation start offset the pre one
    var ascend: BOOL    //true: scorll from top， false: scroll from bottom
    
    //TODO: if change these properties, should reconstruct subviews
    var value: Int?             //value of number
    var density: Int    //count of numbers to scroll in vertical direction
    var minLength: Int  //min length
    
    func startAnimation() {
        //TODO: wait to implementate
    }
    
    func stopAnimation() {
        //TODO: wait to implementate
    }
    
    override func layoutSubviews() {
        //TOOD: change color, font
    }
    
    private func constructSubviews() {
        //TODO:construct subviews for value
    }
}
