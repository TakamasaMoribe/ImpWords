//
//  ResultViewController.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/14.
//  Copyright © 2020 森部高昌. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    //現在の問題のインデックス
    var  nowQuestionIndex:Int = 0
    
    @IBOutlet weak var correctPercentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //問題数の取得  QuestionDataManeger.sharedInstance.questionDataArray *******
        let questionCount = QuestionDataManeger.sharedInstance.questionDataArray.count
        //正解数の取得
        var correctCount:Int = 0
        //正解数を計算する  QuestionDataManeger.sharedInstance.questionDataArray ******
            for questionData in QuestionDataManeger.sharedInstance.questionDataArray {
                if questionData.isCorrect() {
                    correctCount += 1
                }
            }
        //正解率の計算
        let correctPercent:Float = (Float(correctCount)/Float(questionCount)) * 100
        //小数第一位まで計算して表示
        correctPercentLabel.text = String(format: "%.1f", correctPercent) + "%"
    }

    
    @IBAction func clickNextQuestionButton(_ sender: Any) { //出題画面へ戻るボタンをクリック
  
        //問題文の取り出し  QuestionDataManeger.sharedInstance.nextQuestion ****

         guard let nextQuestion = QuestionDataManeger.sharedInstance.nextQuestion()else {
             return
         }
         //次の問題文を表示する
         if let nextQuestionViewController = storyboard?.instantiateViewController(identifier: "question") as? QuestionViewController {
             nextQuestionViewController.questionData = nextQuestion
             //StoryboardのSegueを利用しない明示的な画面遷移処理
             present(nextQuestionViewController,animated: true,completion: nil)
         }
        
    }
    
    
}
