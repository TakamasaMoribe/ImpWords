//
//  StartViewController.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/14.
//  Copyright © 2020 森部高昌. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //次画面に移る前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //問題文の読み込み
        QuestionDataManeger.sharedInstance.loadQuestion()
        //遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            return
        }
        //問題文の取り出し
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
