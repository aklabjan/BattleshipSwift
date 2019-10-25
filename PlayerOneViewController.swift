//
//  PlayerOneViewController.swift
//  Battleship
//
//  Created by Ana Klabjan on 5/11/18.
//  Copyright © 2018 Ana Klabjan. All rights reserved.
//

import UIKit

class PlayerOneViewController: UIViewController
{
    var playerOneShips = [-1,-1,-1,-1,-1,-1,-1,-1]
    var playerOneGameBoard = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]
    var playerOneShipsSunk = 0
    
    var playerTwoShips = [-1,-1,-1,-1,-1,-1,-1,-1]
    var playerTwoShipsSunk = 0
    var playerTwoGameBoard = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]
    
    var numberOfShipsChoosen = 0
    var player = 1
    var shipsChoosen = false
    var hit = false
    var active = true
    var gameOver = false
    
    @IBOutlet weak var whoIsPlaying: UILabel!
    @IBOutlet weak var winner: UILabel!
    @IBOutlet weak var switchPlayerVisibility: UIButton!
    
    
    @IBAction func SwitchPlayer(_ sender: UIButton)
    {
        if active == false && gameOver == false
        {
            if player == 2
            {
                whoIsPlaying.text = "Player 2"
                updateBoard(player : 2)
                sender.setTitle("Player 1's Turn",for: .normal)
                sender.isHidden = true
                numberOfShipsChoosen = 0
            }
            else
            {
                whoIsPlaying.text = "Player 1"
                updateBoard(player : 1)
                sender.setTitle("Player 2's Turn",for: .normal)
                sender.isHidden = true
            }
            active = true
        }
    }
    
    func updateBoard(player : Int)
    {
        if player == 1
        {
            for i in 1...100
            {
                if playerOneGameBoard[i-1] == 0 //empty
                {
                    let button = view.viewWithTag(i) as! UIButton
                    button.setImage(nil, for: UIControlState()) //set image to null
                }
                else if playerOneGameBoard[i-1] == 1 //water(square shot at but missed)
                {
                    let button = view.viewWithTag(i) as! UIButton
                    let image: UIImage = UIImage(named: "Water.png")!
                    button.setImage(image, for: UIControlState())
                    
                }
                else if playerOneGameBoard[i-1] == 2 //fire(ship was sank at location)
                {
                    
                    let button = view.viewWithTag(i) as! UIButton
                    let image: UIImage = UIImage(named: "Fire")!
                    button.setImage(image, for: UIControlState())
                }
            }
        }
        else
        {
            for i in 1...100
            {
                if playerTwoGameBoard[i-1] == 0 //empty
                {
                    let button = view.viewWithTag(i) as! UIButton
                    button.setImage(nil, for: UIControlState()) //set image to null
                }
                else if playerTwoGameBoard[i-1] == 1 //water(square shot at but missed)
                {
                    let button = view.viewWithTag(i) as! UIButton
                    let image: UIImage = UIImage(named: "Water.png")!
                    button.setImage(image, for: UIControlState())
                }
                else if playerTwoGameBoard[i-1] == 2 //fire(ship was sank at location)
                {
                    let button = view.viewWithTag(i) as! UIButton
                    let image: UIImage = UIImage(named: "Fire")!
                    button.setImage(image, for: UIControlState())
                }
            }
        }
    }
    
    @IBAction func SquarePressed(_ sender: UIButton)
    {
        if active == true
        {
            if shipsChoosen == false
            {
                if player == 1 && numberOfShipsChoosen != 8
                {
                    var validShip = true
                    for i in 0...7  //checks if valid ship
                    {
                        if playerOneShips[i] == sender.tag
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 0 && sender.tag >= 10 && playerOneShips[i] == sender.tag - 11
                        {
                            validShip = false
                        }
                        else if sender.tag >= 10 && sender.tag - 10 == playerOneShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag < 90 && sender.tag % 10 != 9 && sender.tag + 11 == playerOneShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 0 && sender.tag - 1 == playerOneShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 9 && sender.tag + 1 == playerOneShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag < 90 && sender.tag + 10 == playerOneShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 9 && sender.tag >= 10 && sender.tag - 9 == playerOneShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 0 && sender.tag < 90 && sender.tag + 9 == playerOneShips[i]
                        {
                            validShip = false
                        }
                    }
                    if validShip == true
                    {
                        //adds ship
                        playerOneShips[numberOfShipsChoosen] = sender.tag
                        sender.setImage(UIImage(named: "Ship"), for: UIControlState())
                        numberOfShipsChoosen += 1
                        if numberOfShipsChoosen == 8 //checks if all ships choosen
                        {
                            player = 2
                            active = false
                            switchPlayerVisibility.isHidden = false
                        }
                    }
                }
                if player == 2 && numberOfShipsChoosen != 8
                {
                    var validShip = true
                    for i in 0...7 //checks if valid place to add ship
                    {
                        if playerTwoShips[i] == sender.tag
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 0 && sender.tag >= 10 && playerTwoShips[i] == sender.tag - 11
                        {
                            validShip = false
                        }
                        else if sender.tag >= 10 && sender.tag - 10 == playerTwoShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag < 90 && sender.tag % 10 != 9 && sender.tag + 11 == playerTwoShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 0 && sender.tag - 1 == playerTwoShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 9 && sender.tag + 1 == playerTwoShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag < 90 && sender.tag + 10 == playerTwoShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 9 && sender.tag >= 10 && sender.tag - 9 == playerTwoShips[i]
                        {
                            validShip = false
                        }
                        else if sender.tag % 10 != 0 && sender.tag < 90 && sender.tag + 9 == playerOneShips[i]
                        {
                            validShip = false
                        }
                    }
                    if validShip == true
                    {
                        //sets ship
                        playerTwoShips[numberOfShipsChoosen] = sender.tag
                        sender.setImage(UIImage(named: "Ship.png"), for: UIControlState())
                        numberOfShipsChoosen += 1
                        if numberOfShipsChoosen == 8 //check if all ships are placed
                        {
                            player = 1
                            shipsChoosen = true
                            active = false
                            switchPlayerVisibility.isHidden = false
                        }
                    }
                }
            }
            else //once ships have been set
            {
                if player == 1
                {
                    if playerOneGameBoard[sender.tag-1] != 1 && playerOneGameBoard[sender.tag-1] != 2 //if not already choosen by player
                    {
                        for i in 0...7
                        {
                            if playerTwoShips[i] == sender.tag // checks if hit other player
                            {
                                hit = true
                            }
                        }
                        if hit == true
                        {
                            playerOneGameBoard[sender.tag-1] = 2
                            sender.setImage(UIImage(named: "Fire"), for: UIControlState())
                            playerOneShipsSunk += 1
                            if playerOneShipsSunk == 8
                            {
                                winner.text = "Player 1 has won!"
                                winner.isHidden = false
                                active = false
                                gameOver = true
                            }
                            else
                            {
                                hit = false
                            }
                        }
                        else
                        {
                            playerOneGameBoard[sender.tag-1] = 1
                            sender.setImage(UIImage(named: "Water"), for: UIControlState())
                            player = 2
                            active = false
                            switchPlayerVisibility.isHidden = false
                        }
                    }
                }
                else
                {
                    if playerTwoGameBoard[sender.tag-1] != 1 && playerTwoGameBoard[sender.tag-1] != 2 //if not already choosen by player
                    {
                        for i in 0...7
                        {
                            if playerOneShips[i] == sender.tag // checks if hit other player
                            {
                                hit = true
                            }
                        }
                        if hit == true
                        {
                            playerTwoGameBoard[sender.tag-1] = 2
                            sender.setImage(UIImage(named: "Fire"), for: UIControlState())
                            playerTwoShipsSunk += 1
                            if playerTwoShipsSunk == 8
                            {
                                winner.text = "Player 2 has won!"
                                winner.isHidden = false
                                active = false
                                gameOver = true
                            }
                            else
                            {
                                hit = false
                            }
                        }
                        else
                        {
                            playerTwoGameBoard[sender.tag-1] = 1
                            sender.setImage(UIImage(named: "Water"), for: UIControlState())
                            player = 1
                            active = false
                            switchPlayerVisibility.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
