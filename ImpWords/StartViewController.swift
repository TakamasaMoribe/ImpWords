//
//  StartViewController.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/14.
//  Copyright © 2020 森部高昌. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    let singleton:Singleton = Singleton.sharedInstance//シングルトンインスタンス******

    @IBOutlet weak var gradeSegment: UISegmentedControl! //学年名

    @IBOutlet weak var unitSegment: UISegmentedControl!  //単元名
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //次画面に移る前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        //セグメンティッドコントロールから問題ファイル名を取得する
         var filename:String //ファイル名（拡張子を除いた本体のみ）
         //選択されているセグメントのインデックス（学年名）
         let selectedGradeIndex = gradeSegment.selectedSegmentIndex
         //選択されたインデックスの文字列を取得してファイル名（学年名）に設定する
         let text1 = gradeSegment.titleForSegment(at: selectedGradeIndex)
         //（単元名）
         let selectedUnitIndex = unitSegment.selectedSegmentIndex
         //（単元名）
         let text2 = unitSegment.titleForSegment(at: selectedUnitIndex)
         //ファイル名の生成　学年名＋単元名
         filename = text1! + text2!
         singleton.saveItem(item: filename) //ファイル名を　シングルトンへ保存　読み込みで使用

        //問題文の読み込み  sharedInstance.loadQuestion() ****
        QuestionDataManeger.sharedInstance.loadQuestion()
        //遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            return
        }
        //問題文の取り出し  sharedInstance.nextQuestion() ****
        guard let questionData = QuestionDataManeger.sharedInstance.nextQuestion() else {
            return
        }
        //問題文のセット
        nextViewController.questionData = questionData
    }
    
    //タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTitle(_ segue:UIStoryboardSegue){
    }

    
}



