//
//  ViewController.swift
//  SimpleTestDemo
//
//  Created by dev on 6/19/16.
//  Copyright © 2016 zfx5130. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var blockArray : [(Int) -> Int] = []
    //var square = { (val: Int) -> Int in return val * val }
    
    //var square: Int -> Int = {val in return val * val}
    var square: Int -> Int = {val in return val * val}
    //使用闭包表达式定义闭包，并在闭包表达式后面增加圆括号来调用该闭包。
//    var test = { (base: Int, value: Int) -> Int in
//        var result = 1
//        for _ in 1...value {
//            result *= base
//        }
//        return result
//    }(2, 3)
    
//    var test: (Int, Int) -> Int = { base, value in
//        var result = 1
//        for _ in 1...value {
//            result *= base
//        }
//        return result
//    }
    
    //因为可以推断出闭包表达式后面的形参类型(2, 3)为(Int,Int),所以对于闭包可以省略形参和返回值类型
    var test: Int = { base, value in
        var result = 1
        for _ in 1...value {
            result *= base
        }
        return result
    }(2, 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTest()
        collectionTestOne({$0 + $0})
        print(square(5))
        print(test)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func addTest() {
        //默认情况下，作为函数参数传入的闭包的闭包可以脱离函数独立使用。
        collectionTest({$0 * $0})
        collectionTest({$0 * $0 * $0})
        print("\(blockArray.count)")

        for i in 0 ..< blockArray.count {
            print(blockArray[i](i + 10))
        }
    }
    
}

extension ViewController {
    //@noescape 如果添加@noescape关键字，就限制了作为参数传入的闭包只能在该函数内使用
    private func collectionTest(test: (Int) -> Int) {
        blockArray.append(test)
    }
    
    private func collectionTestOne(@noescape test: (Int) -> Int) {
         print(test(100))
    }
    
    //闭包表达式1
    //{（形参列表） -> 返回值类型 in 零条到多条可执行语句 }
    
    //闭包表达式2
    //{（形参列表）—> 返回值类型 }
    
    //闭包表达式3 
    //{ 形参列表 —>  返回值类型 }
    
    
    //Swift可以肯局闭包表达式上下文推断形参类型，返回值类型，所以闭包表达式就可以省略形参类型，返回值类型。
    
    
}


