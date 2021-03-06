//
//  ViewController.swift
//  sillysong
//
//  Created by Udumala, Mary on 1/9/17.
//  Copyright © 2017 Udumala, Mary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var nameField: UITextField!

    @IBOutlet var lyricsView: UITextView!
    
    
    @IBAction func reset(_ sender: Any) {
        nameField.text?.removeAll()
        lyricsView.text.removeAll()
        nameField.autocapitalizationType = .words
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
             if let name = nameField.text {
             lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: name)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.returnKeyType = UIReturnKeyType.done
    }

}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

func shortNameFromName(name: String) -> String {
    var nameArray = [Character]()
    var shortenedName = ""
    
    for eachchar in name.lowercased().characters {
        nameArray.append(eachchar)
    }
    
    let vowels: [Character] = ["a","e","i","o","u"]
    
    if let firstLetter = name.lowercased().characters.first {
        if !(vowels.contains(firstLetter)) {
            nameArray.remove(at: 0)
        }
    }
    
    for eachCharElement in nameArray {
        shortenedName.append(eachCharElement)
    }
    
    return shortenedName
}


func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortenedname = shortNameFromName(name: fullName)
    let newTemplate = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortenedname)
    return newTemplate
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


