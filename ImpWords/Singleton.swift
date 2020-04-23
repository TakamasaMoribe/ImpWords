//
//  Singleton.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/21.
//  Copyright © 2020 森部高昌. All rights reserved.
//


import Foundation

class Singleton {
    var filename = Filename(item:"")  //問題ファイルの名前
    var questionIndex = QuestionIndex(number:0) //問題配列のインデックス
    
    static let sharedInstance:Singleton = Singleton() //で使う

    func saveItem(item:String)  { //保存
        filename.item = item
    }
    func saveNumber(number:Int)  { //保存
        questionIndex.number = number
    }
    
    func getItem() -> String { //読み込み
        return filename.item
    }
    func getNumber() -> Int { //読み込み
        return questionIndex.number
    }
}


class Filename {  //問題ファイルの名前
    var item:String
    init(item:String) {
        self.item = item
    }
}

class QuestionIndex {  //問題配列のインデックス
    var number:Int
    init(number:Int) {
        self.number = number
    }
}




