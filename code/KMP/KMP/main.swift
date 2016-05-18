//
//  main.swift
//  KMP
//
//  Created by tanghaibo on 16/5/18.
//  Copyright © 2016年 tanghaibo. All rights reserved.
//

import Foundation

// KMP字符串搜索算法

import Cocoa

//0 12345678
//a babaaabc
//-100124530

func constructNext(pattern: UnsafePointer<CChar>) -> [Int]? {
    if strlen(pattern) == 0 {
        return nil
    }
    
    var next = [-1]
    for i in 1 ..< Int(strlen(pattern)) {
        if 1 == i{
            next.append(0)
            continue
        }

        var j = i - 1
        while j >= 0 {
            if j == 0 || pattern[i] == pattern[j] {
                next.append(j)
                break
            }
            
            j = next[j]
        }
        
    }
    
    return next
}

func kmpSubstring(text: UnsafePointer<CChar>, pattern: UnsafePointer<CChar>) -> NSInteger? {
    if strlen(text) == 0 || strlen(pattern) == 0 {
        return nil
    }
    
    var next = constructNext(pattern)!
    
    //i控制text的位置
    //j控制pattern的位置
    var j = 0
    var i = 0
    let lenText = Int(strlen(text))
    let lenPattern = Int(strlen(pattern))
    //时间复杂度O(lenPattern+lenText)
    while j < lenPattern && i < lenText {
        if text[i+j] == pattern[j] {
            //可执行lenPattern次
            j += 1
        } else {
            //可执行lenText次
            let oj = j
            j = next[j]
            i += oj - j
        }
        
        //可执行lenPattern＋lenText次
        if j == -1 {
            j = 0
        }
    }
    
    if i < lenText && j == lenPattern {
        return i
    } else {
        return nil
    }
}


print(kmpSubstring("func kmpSubstring(text: UnsafePointer<CChar>, pattern: UnsafePointer<CChar>) -> NSInteger? {", pattern: "lenPattern"))

