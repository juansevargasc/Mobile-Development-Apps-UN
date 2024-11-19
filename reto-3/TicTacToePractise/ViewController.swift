//
//  ViewController.swift
//  TicTacToePractise
//
//  Created by mac on 02/01/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ticTacToeColView : UICollectionView!
    var isOSelected = true
    let winPosition = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    var board: [String] = ["", "", "", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func refreshAction(){
        for i in 0...8{
            board[i] = ""
        }
        ticTacToeColView.reloadData()
    }
    func checkWinner() {
        for position in winPosition {
            if board[position[0]] != "" && board[position[0]] == board[position[1]] && board[position[1]] == board[position[2]] {
                if board[position[0]] == "X" {
                    let alert = UIAlertController(title: "Alert", message: "Player X wins", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Player 0 wins", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        var totalPoint = ""
        for i in 0...8 {
            totalPoint += board[i]
        }
        
        if totalPoint.count == 9 {
            let alert = UIAlertController(title: "Alert", message: "Game Draw", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTacToeCollectionViewCell", for: indexPath) as? TicTacToeCollectionViewCell{
        let data = board[indexPath.row]
        cell.nameLabel.text = data
        return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if board[indexPath.row] != "X" || board[indexPath.row] != "O"{
            if isOSelected{
                board[indexPath.row] = "O"
            }else{
                board[indexPath.row] = "X"
            }
            isOSelected.toggle()
            checkWinner()
        }
        collectionView.reloadItems(at: [indexPath])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}



class TicTacToeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel : UILabel!
}
