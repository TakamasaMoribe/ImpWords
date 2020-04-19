//
//  QuestionViewController.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/13.
//  Copyright © 2020 森部高昌. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
    
    var questionData:QuestionData! //前画面より受け取るデータ
    var nowQuestionIndex:Int = 0
    
    @IBOutlet weak var progressView: UIProgressView! //解答の進行状況
    
    @IBOutlet weak var questionNoLabel: UILabel!     //問題番号
    @IBOutlet weak var questionTextView: UITextView! //問題文
    @IBOutlet weak var answer1Button: UIButton!      //選択肢１
    @IBOutlet weak var answer2Button: UIButton!      //選択肢２
    @IBOutlet weak var answer3Button: UIButton!      //選択肢３
    @IBOutlet weak var answer4Button: UIButton!      //選択肢４

    @IBOutlet weak var correctImageView: UIImageView!  //正解の画像 ◯
    @IBOutlet weak var incorrectImageView: UIImageView!//不正解の画像　✗
    
    @IBOutlet weak var trueAnswer: UILabel!          //不正解の時、正解を示す hide属性
    @IBOutlet weak var nextQuestionButton: UIButton! //次の問題へ進むボタン　 hide
    
    @IBAction func clickResultButton(_ sender: Any) { //解答の途中で、結果表示をクリックした時
        //問題のインデックスを保持して、結果画面に遷移する
        //結果画面から戻るときに、インデックスをもとに戻す
        //StoryboardのIdentifierに設定した値(result)を使って、ViewControllerを生成する
        //presentメソッドは、セグエを利用せずに画面をモーダルで表示するメソッド
         if let nextQuestionViewController = storyboard?.instantiateViewController(identifier: "result") as? QuestionViewController {
             nextQuestionViewController.nowQuestionIndex = questionData.questionNo//現在の問題番号に入れる
             //StoryboardのSegueを利用しない明示的な画面遷移処理
             present(nextQuestionViewController,animated: true,completion: nil)
         }
    }
// //       セグエを使って、問題番号の値を渡す
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "result" {
//                let nextVC = segue.destination as! ResultViewController
//                nextVC.nowQuestionIndex = questionData.questionNo //問題番号を現在の問題番号に入れる
//                }
//            }
//
        
    
    @IBAction func clickStopButton(_ sender: Any) {
    } // 中止ボタンをクリックした時  goToTittleと同じ動作
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //問題数の取得  QuestionDataManeger.sharedInstance.questionDataArray****
        let questionCount = QuestionDataManeger.sharedInstance.questionDataArray.count
        
        //初期データ設定。前画面から受け取ったquestionDataから値を取り出す
        questionNoLabel.text = "Q.\(questionData.questionNo)" + "/\(questionCount)"
        questionTextView.text = questionData.question //問題文
        answer1Button.setTitle(questionData.answer1, for: UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControl.State.normal)
        trueAnswer.text = questionData.correctAnswer //正答
    
        //解答の進行状況を表示する
            var degree:Float = 0.0 //進み具合
            degree = Float(questionData.questionNo) / Float(questionCount)
            progressView.progress = degree //progressView を動かす
        
    }
    // end of override func viewDidLoad() ------------------------------------------------
    
    //選択肢１を選んだ時
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswer = answer1Button.title(for: UIControl.State.normal)!//answer1を選んだ
        goNextQuestionWithAnimation()
    }
    //選択肢2を選んだ時
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswer = answer2Button.title(for: UIControl.State.normal)!//answer2を選んだ
     goNextQuestionWithAnimation()
    }
    //選択肢3を選んだ時
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswer = answer3Button.title(for: UIControl.State.normal)!//answer3を選んだ
        goNextQuestionWithAnimation()
    }
    //選択肢4を選んだ時
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswer = answer4Button.title(for: UIControl.State.normal)!//answer4を選んだ
        goNextQuestionWithAnimation()
    }

    //正誤判定
    func goNextQuestionWithAnimation()  {
        if questionData.isCorrect() {
            goCorrectAnimation()//正解の時
        }else{
            goIncorrectAnimation()//不正解の時
        }
    }
    
    //正答の時
    func goCorrectAnimation()  {
        AudioServicesPlayAlertSound(1025) //正解音を鳴らす
        //正解のイメージとアニメーション
        UIView.animate(withDuration: 1.0, animations: {self.correctImageView.alpha = 1.0
        }){(Bool) in self.goNextQuestion() //アニメーション後に次の問題へ進む
        }
    }
    
    //誤答の時
    func goIncorrectAnimation()  {
        AudioServicesPlayAlertSound(1006) //誤答音を鳴らす
        //不正解のイメージとアニメーション
        UIView.animate(withDuration: 1.0, animations: {self.incorrectImageView.alpha = 1.0})
        {(Bool) in self.showCorrectAnswer() //正答を表示する
        }
    }
    
    //誤答の時には、正答を表示する
    func showCorrectAnswer()  {
        trueAnswer.isHidden = false//HIDDEN　解除
        trueAnswer.text = "正解は:" + questionData.correctAnswer // 正答表示
        nextQuestionButton.isHidden = false//HIDDENを解除してボタンを表示する
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        goNextQuestion()//不正解時に次の問題へ進む
    }
 
    
    func goNextQuestion()  {
        //問題文の取り出し  QuestionDataManeger.sharedInstance.nextQuestion ****
        guard let nextQuestion = QuestionDataManeger.sharedInstance.nextQuestion() else {
            //問題文に残りがない時 ＝ 最後の問題の時
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                present(resultViewController,animated: true,completion: nil)
            }
            return
        }
        
        //問題文に残りがあり、次の問題文を表示する時
        //StoryboardのIdentifierに設定した値(question)を使って、ViewControllerを生成する
        //presentメソッドは、セグエを利用せずに画面をモーダルで表示するメソッド
        if let nextQuestionViewController = storyboard?.instantiateViewController(identifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            //StoryboardのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController,animated: true,completion: nil)
        }
    }
 

}
