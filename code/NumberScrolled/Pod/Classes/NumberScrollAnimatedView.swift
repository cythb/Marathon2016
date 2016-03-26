//
//  NumberScrollAnimatedView.swift
//  Pods
//
//  Created by tanghaibo on 16/3/24.
//
//

import Foundation
import SnapKit

public class NumberScrollAnimatedView: UIView {
    //if change these properties, should update the corresponding view
    public var textColor = UIColor.whiteColor()
    public var textFont = UIFont.systemFontOfSize(42)
    
    //change this property not effet the runing animation
    public var duration = 1.5
    public var durationOffset = 0.2
    public var ascend = false //from up or from dwon
    
    //if change these properties, should reconstruct subviews
    public var value: Int? //value of number
    public var density = 6
    public var minLength = 4
    
    //MARK: - init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
    }
    
    private func constructNumCell(num: Int) -> UIView? {
        let cell = UIView()
        cell.backgroundColor = UIColor.redColor()
        var prelabel: UILabel? = nil
        
        for i in 0 ..< density {
            let label = UILabel()
            cell.addSubview(label)
            label.snp_makeConstraints(closure: { (make) in
                make.leadingMargin.trailingMargin.equalTo(0)
                
                if nil == prelabel {
                    make.topMargin.equalTo(0)
                }else {
                    make.topMargin.equalTo(prelabel!.snp_bottomMargin)
                }
                make.height.equalTo(cell.snp_height)
                
                prelabel = label
            })
            label.textAlignment = .Center
            label.textColor = textColor
            label.font = textFont
        }
        
        var labels = cell.subviews as! [UILabel]
        if !ascend {
            labels = labels.reverse()
        }
        
        var value: Int = num
        for label in labels {
            label.text = "\(value)"
            value = (value + 1) % 10
        }
        
        return cell
    }
    
    private func constructView() {
        //num cell1 | num cell2 | num cell3 | num cell4
        
        guard let number = value else {
            return
        }
        
        var numStr = "\(number)"
        let supplement = minLength - numStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        for _ in 0 ..< supplement {
            numStr.insert("0", atIndex: numStr.startIndex)
        }
        
        var preSubview: UIView? = nil
        for i in 0 ..< numStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) {
            let myRange = numStr.startIndex.advancedBy(i) ..< numStr.startIndex.advancedBy(i+1)
            let num = numStr.substringWithRange(myRange)
            if let v = constructNumCell(Int(num)!) {
                self.addSubview(v)
                
                v.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(0)
                    
                    if nil == preSubview {
                        make.leadingMargin.equalTo(0)
                    } else {
                        make.leadingMargin.equalTo(preSubview!.snp_trailing)
                        make.width.equalTo(preSubview!.snp_width)
                    }
                    
                    if i == numStr.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - 1 {
                        make.trailingMargin.equalTo(0)
                    }
                })
                
                preSubview = v
            }
        }
    }
    
    private func setupAnimation() {
        layoutIfNeeded()
        
        let cells = subviews
        var d = duration - Double(cells.count) * durationOffset
        
        for cell in cells {
            d += durationOffset
            let minY = CGRectGetMinY(cell.subviews.last!.frame)
            
            let ani = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
            ani.duration = d
            ani.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            ani.removedOnCompletion = false
            ani.fillMode = kCAFillModeForwards
            if ascend {
                ani.fromValue = minY * (-1)
                ani.toValue = 0
            }else {
                ani.fromValue = 0
                ani.toValue = minY * (-1)
            }
            cell.layer.addAnimation(ani, forKey: "NumberScrollAnimatedView")
            
            print(cell.subviews)
        }
    }
    
    //MARK: - Actions
    public func startAnimation() {
        //remove all subviews
        for v in subviews {
            v.removeFromSuperview()
        }
        
        constructView()
        setupAnimation()
    }
    
    public func stopAnimation() {
        let cells = subviews
        for cell in cells {
            cell.layer.removeAnimationForKey("NumberScrollAnimatedView")
        }
    }
}
