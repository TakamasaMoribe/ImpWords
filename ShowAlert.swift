//
//  ShowAlert.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/24.
//  Copyright © 2020 森部高昌. All rights reserved.
//

import UIKit

class ShowAlert:UIViewController {

// ボタンを押下した時にアラートを表示するメソッド
@IBAction func dispAlert(sender: UIButton) {

    // ① UIAlertControllerクラスのインスタンスを生成
    // タイトル, メッセージ, Alertのスタイルを指定する
    // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
    let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "保存してもいいですか？", preferredStyle:  UIAlertController.Style.alert)

    // ② Actionの設定
    // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
    // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
    // OKボタン
    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
        // ボタンが押された時の処理を書く（クロージャ実装）
        (action: UIAlertAction!) -> Void in
        print("OK")
    })
    // キャンセルボタン
    let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
        // ボタンが押された時の処理を書く（クロージャ実装）
        (action: UIAlertAction!) -> Void in
        print("Cancel")
    })

    // ③ UIAlertControllerにActionを追加
    alert.addAction(cancelAction)
    alert.addAction(defaultAction)

    // ④ Alertを表示
    present(alert, animated: true, completion: nil)
}

}
