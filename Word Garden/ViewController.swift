//
//  ViewController.swift
//  Word Garden
//
//  Created by Andrew Boucher on 9/15/19.
//  Copyright © 2019 Andres de la Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    
    @IBOutlet weak var guessedLetterField: UITextField!
    
    @IBOutlet weak var guessedLetterButtom: UIButton!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var flowerImage: UIImageView!
    
    var wordToGuess = ["SWIFT", "CODE", "APPS", "WIN", "CONGRATS"]
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    var currentWordToGuess = ""
    var n = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessedLetterButtom.isEnabled = false
        playAgainButton.isHidden = true
       
        
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        let currentWordToGuess = wordToGuess[n]
        
        for letter in currentWordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord += " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        let currentWordToGuess = wordToGuess[n]
        let currentLetterGuessed = guessedLetterField.text!
        
        if !currentWordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining = wrongGuessesRemaining - 1
            flowerImage.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        let revealedWord = userGuessLabel.text!
        
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterButtom.isEnabled = false
            guessedLetterField.isEnabled = false
            guessCountLabel.text = "Sorry, You're Out of Guesses. Try Again?"
        }else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterButtom.isEnabled = false
            guessedLetterField.isEnabled = false
            guessCountLabel.text = "You've Got It! It Took You \(guessCount) Guesses to Guess the Word!"
        }else {
            let guess = (guessCount == 1 ? "Guess":"Guesses")
        guessCountLabel.text = "You've Made \(guessCount) \(guess)"
        }
    }

    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    @IBAction func guessedLetterChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessedLetterButtom.isEnabled = true
        } else {
            guessedLetterButtom.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessedLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterButtom.isEnabled = true
        guessedLetterField.isEnabled = true
        flowerImage.image = UIImage (named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        guessCountLabel.text = "You've Made 0 Guesses"
        guessCount = 0
        n += 1
        if n > 4 {
            n = 0
        }
        formatUserGuessLabel()
        
    }
    


}

