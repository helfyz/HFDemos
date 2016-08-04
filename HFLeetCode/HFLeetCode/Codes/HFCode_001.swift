//
//  HFCode_001.swift
//  HFLeetCode
//
//  Created by helfy on 16/8/3.
//  Copyright © 2016年 HF. All rights reserved.
//

import Foundation

class HFCode_001 {
    
    func twoSum(num: [Int], _ targer :Int) -> [Int] {
        
        var result = [Int]()
        var keyMap = [Int :Int]()

        for index in 0..<num.count {
            
            let curValue = num[index]
            let dif = targer - curValue
            if let findIndex = keyMap[dif] {
                result.append(findIndex)
                result.append(index)
            }
            
            keyMap[curValue] = index
        }
        return result
    }
    
}