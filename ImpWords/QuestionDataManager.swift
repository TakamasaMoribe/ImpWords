//
//  QuestionDataManager.swift
//  ImpWords
//
//  Created by 森部高昌 on 2020/04/13.
//  Copyright © 2020 森部高昌. All rights reserved.
//

import Foundation

//１つの問題に関する情報
class QuestionData {
    
    var qNo:String  //問題番号 固有の番号　ｃｓｖファイルに記載されている
    var question:String  //問題文
    var correctAnswer:String  //正解
    var answer1:String   //選択肢１
    var answer2:String   //選択肢２
    var answer3:String   //選択肢３
    var answer4:String   //選択肢４
    var userChoiceAnswer:String = "" //ユーザーが選択した答
    var questionNo:Int = 0 //出題番号
//       var sumOfQuestions:Int = 0 //問題の総数
    
    init(questionSourceDataArray:[String]) {
        qNo = questionSourceDataArray[0]
        question = questionSourceDataArray[1]
        correctAnswer = questionSourceDataArray[2]
        answer1 = questionSourceDataArray[3]
        answer2 = questionSourceDataArray[4]
        answer3 = questionSourceDataArray[5]
        answer4 = questionSourceDataArray[6]
    }
    
    //正誤の判定
    func isCorrect() -> Bool {
        if correctAnswer == userChoiceAnswer {
            return true
        }
        return false
    }
    
}

class QuestionDataManeger {
    //シングルトン
    static let sharedInstance = QuestionDataManeger()
    
    //問題を格納するための配列
    var questionDataArray = [QuestionData]()
    
    //現在の問題のインデックス
    var  nowQuestionIndex:Int = 0
    
 //   var sumOfQuestions:Int = 1
    
    
    private init(){
        //シングルトンであることを保証するため
    }
    
    //問題文の読み込み-----------------------------
    func loadQuestion()  {
        questionDataArray.removeAll()
        nowQuestionIndex = 0
        
        //CSV問題ファイル　パスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            print("ファイルが存在しません")
            return
        }
        //csv問題ファイル　読み込み
        
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath,encoding: String.Encoding.utf8)
            csvStringData.enumerateLines(invoking: {(line,stop) in
                let questionSourceDataArray = line.components(separatedBy: ",")
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                self.questionDataArray.append(questionData)
                questionData.questionNo = self.questionDataArray.count
            })
  //          sumOfQuestions = questionDataArray.count//問題の総数
  //         print(sumOfQuestions)
            
        }catch let error {
            print("ファイル読み込みエラー:\(error)")
            return
        }
        
        
    }
    
    //次の問題を取り出す
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
}
