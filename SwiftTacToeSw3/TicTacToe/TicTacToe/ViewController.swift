//
//  ViewController.swift
//  TicTacToe
//
//  Created by Cheena Malhotra on 2017-06-04.
//  Copyright © 2017 Cheena Malhotra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacBtn1: UIButton!
    @IBOutlet var ticTacBtn2: UIButton!
    @IBOutlet var ticTacBtn3: UIButton!
    @IBOutlet var ticTacBtn4: UIButton!
    @IBOutlet var ticTacBtn5: UIButton!
    @IBOutlet var ticTacBtn6: UIButton!
    @IBOutlet var ticTacBtn7: UIButton!
    @IBOutlet var ticTacBtn8: UIButton!
    @IBOutlet var ticTacBtn9: UIButton!
    
    @IBOutlet var resetBtn: UIButton!
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    @IBAction func UIButtonClicked(_ sender : UIButton){
        userMessage.isHidden = true;
        if((plays[sender.tag] == nil) && !aiDeciding && !done){
            setImageForSpot(spot: sender.tag, player: 1)
        }
        checkForWin()
        aiTurn()
    }
    
    func setImageForSpot(spot:Int, player:Int){
        let playerMark = player == 1 ? "x" : "o"
        plays[spot] = player
        switch spot{
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg5.image = UIImage(named: playerMark)
        }
    }
    
    func checkForWin(){
        let whoWon = ["I":0,"You":1]
        for(key,value) in whoWon{
            if((plays[7] == value && plays[8] == value && plays[9] == value) || //bottom row match
                (plays[4] == value && plays[5] == value && plays[6] == value) || //middle row match
                (plays[1] == value && plays[2] == value && plays[3] == value) || //top row match
                (plays[1] == value && plays[4] == value && plays[7] == value) || //first col match
                (plays[2] == value && plays[5] == value && plays[8] == value) || //sec col match
                (plays[3] == value && plays[6] == value && plays[9] == value) || //third col match
                (plays[1] == value && plays[5] == value && plays[9] == value) || //first cross
                (plays[3] == value && plays[5] == value && plays[7] == value) //second cross
                ){
                userMessage.isHidden = false
                userMessage.text = "Looks like \(key) won"
                resetBtn.isHidden = false
                done = true
            }
        }
        
    }
    
    func checkBottom(value:Int) -> (location:String, pattern:String){
        return ("bottom", checkFor(value: value, inList: [7,8,9]))
    }
    
    func checkTop(value:Int) -> (location:String, pattern:String){
        return ("top", checkFor(value: value, inList: [1,2,3]))
    }
    
    func checkLeft(value:Int) -> (location:String, pattern:String){
        return ("left", checkFor(value: value, inList: [1,4,7]))
    }
    
    func checkRight(value:Int) -> (location:String, pattern:String){
        return ("right", checkFor(value: value, inList: [3,6,9]))
    }
    
    func checkMiddleAcross(value:Int) -> (location:String, pattern:String){
        return ("middleAcross", checkFor(value: value, inList: [4,5,6]))
    }
    
    func checkMiddleDown(value:Int) -> (location:String, pattern:String){
        return ("middleDown", checkFor(value: value, inList: [2,5,8]))
    }
    
    func checkDiagLeftRight(value:Int) -> (location:String, pattern:String){
        return ("diagLeftRight", checkFor(value: value, inList: [1,5,9]))
    }
    
    func checkDiagRightLeft(value:Int) -> (location:String, pattern:String){
        return ("diagRightLeft", checkFor(value: value, inList: [3,5,7]))
    }
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if(plays[cell] == value){
                conclusion.append("1")
            }else{
                conclusion.append("0")
            }
        }
        return conclusion
    }
    
    func reset(){
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
    }
    
    func rowCheck(value:Int) -> (location:String,pattern:String){
        let acceptableFinds = ["110","101","011"]
        let findFuncs = [checkTop, checkBottom, checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findFuncs{
            let algorithmResults = algorithm(value)
            if acceptableFinds.contains(algorithmResults.pattern) {
                return algorithmResults
            }
        }
        return ("","")
    }
    
    func whereToPlay(location:String, pattern:String) -> Int{
        let leftPattern = "011"
        let rightPattern = "110"
        
        switch location{
        case "top":
            if(pattern == leftPattern){
                return 1
            }else if(pattern == rightPattern){
                return 3
            }else{
                return 2
            }
        case "bottom":
            if(pattern == leftPattern){
                return 7
            }else if(pattern == rightPattern){
                return 9
            }else{
                return 8
            }
        case "left":
            if(pattern == leftPattern){
                return 1
            }else if(pattern == rightPattern){
                return 7
            }else{
                return 4
            }
        case "right":
            if(pattern == leftPattern){
                return 3
            }else if(pattern == rightPattern){
                return 9
            }else{
                return 6
            }
        case "middleAcross":
            if(pattern == leftPattern){
                return 4
            }else if(pattern == rightPattern){
                return 6
            }else{
                return 5
            }
        case "middleDown":
            if(pattern == leftPattern){
                return 2
            }else if(pattern == rightPattern){
                return 8
            }else{
                return 5
            }
        case "diagLeftRight":
            if(pattern == leftPattern){
                return 1
            }else if(pattern == rightPattern){
                return 9
            }else{
                return 5
            }
        case "diagRightLeft":
            if(pattern == leftPattern){
                return 3
            }else if(pattern == rightPattern){
                return 7
            }else{
                return 5
            }
        default:
            return 4
        }
    }
    
    func isOccupied(spot:Int) -> Bool{
        return (plays[spot] != nil) ? true : false
    }
    
    func firstAvailable(corner:Bool) -> Int{
        let spots = corner ? [1,3,7,9] : [2,4,6,8]
        for spot in spots {
            if(!isOccupied(spot: spot)){
                return spot
            }
        }
        return 0
    }
    
    func aiTurn(){
        if(done){
            return
        }else{
            aiDeciding = true
            
            var result = rowCheck(value: 0)
            if result != ("","") {
                let whereToPlayResult = whereToPlay(location: result.location, pattern: result.pattern)
                if(!isOccupied(spot: whereToPlayResult)){
                    setImageForSpot(spot: whereToPlayResult, player: 0)
                    aiDeciding = false
                    checkForWin()
                    return
                }
            }
            
            result = rowCheck(value: 1)
            if result != ("","") {
                let whereToPlayResult = whereToPlay(location: result.location, pattern: result.pattern)
                if(!isOccupied(spot: whereToPlayResult)){
                    setImageForSpot(spot: whereToPlayResult, player: 0)
                    aiDeciding = false
                    checkForWin()
                    return
                }
            }
            
            if(!isOccupied(spot: 5)){
                setImageForSpot(spot: 5, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
            
            let cornerAvailable = firstAvailable(corner : true)
            if(cornerAvailable != 0){
                setImageForSpot(spot: cornerAvailable, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
            
            let sideAvailable = firstAvailable(corner : false)
            if(sideAvailable != 0){
                setImageForSpot(spot: sideAvailable, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
            
            userMessage.isHidden = false
            userMessage.text = "Looks like its a tie!"
            
            reset()
            
            aiDeciding = false
        }
    }
    
    @IBAction func resetBtnClicked(_ sender: UIButton) {
        done = false
        resetBtn.isHidden = true
        userMessage.isHidden = true
        reset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

