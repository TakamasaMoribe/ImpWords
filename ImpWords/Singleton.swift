//
//  Singleton.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/21.
//  Copyright © 2020 森部高昌. All rights reserved.
//


import Foundation

class Singleton {
    var fileName = FileName(item:"")  //問題ファイルの名前 item
    static let sharedInstance:Singleton = Singleton() //で使う

    func saveItem(item:String)  { //保存
        fileName.item = item
    }
    func getItem() -> String { //読み込み
        return fileName.item
    }

}


class FileName {  //問題ファイルの名前
    var item:String
    init(item:String) {
        self.item = item
    }
}



