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
    
    var qNo:String            //問題番号 固有の番号　ｃｓｖファイルに記載されている
    var question:String       //問題文
    var correctAnswer:String  //正解
    var answer1:String        //選択肢１
    var answer2:String        //選択肢２
    var answer3:String        //選択肢３
    var answer4:String        //選択肢４
    
    var userChoiceAnswer:String = "" //ユーザーが選択した答
    var questionNo:Int = 0    //出題番号

    
    init(questionSourceDataArray:[String]) {
        qNo = questionSourceDataArray[0]           //問題番号
        question = questionSourceDataArray[1]      //問題文
        correctAnswer = questionSourceDataArray[2] //正解
        answer1 = questionSourceDataArray[3]       //選択肢１
        answer2 = questionSourceDataArray[4]       //選択肢２
        answer3 = questionSourceDataArray[5]       //選択肢３
        answer4 = questionSourceDataArray[6]       //選択肢４
    }
    
    //正誤の判定をして、Bool値を返す
    func isCorrect() -> Bool {
        if correctAnswer == userChoiceAnswer {
            return true
        }
        return false
    }
    
}
// end of class QuestionData =============================================


class QuestionDataManeger {
    //シングルトン  sharedInstance = QuestionDataManeger() ******
    static let sharedInstance = QuestionDataManeger()
    //問題を格納するための配列
    var questionDataArray = [QuestionData]()
    //現在の問題のインデックス
    var  nowQuestionIndex:Int = 0
    //シングルトンであることを保証するため
    private init(){
    }
    
    //問題の読み込み　QuestionDataManeger.sharedInstance.loadQuestion() ****
    func loadQuestion()  {
        questionDataArray.removeAll()
        nowQuestionIndex = 0
        
        //問題ファイルのパスを指定する
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            print("ファイルが存在しません")
            return
        }
        //問題ファイルからデータを読み込む
        
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath,encoding: String.Encoding.utf8)
            csvStringData.enumerateLines(invoking: {(line,stop) in
                let questionSourceDataArray = line.components(separatedBy: ",")
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                self.questionDataArray.append(questionData)
                questionData.questionNo = self.questionDataArray.count
            })
            
        }catch let error {
            print("ファイル読み込みエラー:\(error)")
            return
        }
        
    }
    
    //問題文の取り出し  QuestionDataManeger.sharedInstance.nextQuestion() ****
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
}
