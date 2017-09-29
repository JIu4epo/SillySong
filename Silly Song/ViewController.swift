//
//  ViewController.swift
//  Silly Song
//
//  Created by Borys Tkachenko on 9/25/17.
//  Copyright © 2017 Borys Tkachenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
        nameField.returnKeyType = UIReturnKeyType.done
        nameField.autocapitalizationType = UITextAutocapitalizationType.words
    }
    @IBAction func displayLyrics(_ sender: Any) {
        
        let name = (nameField.text?.isEmpty)! ? "" : nameField.text
        let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name!)
        lyricsView.text = lyrics
    }
}
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return false
    }
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    
    var shortName = shortNameForName(name: fullName)
    if shortName.isEmpty {
        shortName = fullName.lowercased()
    }
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameForName(name: String) -> String {
    if !name.isEmpty{
        let lowercaseName = name.lowercased()
        let vowelSet = CharacterSet(charactersIn: "aeiou")
        let firstLetter: String = String(lowercaseName[lowercaseName.startIndex] as Character)
        
        if firstLetter.rangeOfCharacter(from: vowelSet) != nil  {
            return lowercaseName
        } else {
            return shortNameForName(name: String(lowercaseName.dropFirst()))
        }
    } else {
        return ""
    }
}

