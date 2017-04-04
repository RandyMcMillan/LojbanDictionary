//
//  DictionaryEntryViewController.swift
//  LojbanDictionary
//
//  Created by Masato Hagiwara on 4/3/17.
//  Copyright © 2017 Masato Hagiwara. All rights reserved.
//

import UIKit

class DictionaryEntryViewController: UIViewController {
  
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var selmahoLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!

    var entry: DictionaryEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.entry != nil) {
            wordLabel.text = entry!.word
            selmahoLabel.text = entry!.selmaho
            englishLabel.text = entry!.english
            definitionLabel.text = entry!.definition
            definitionLabel.sizeToFit()
            notesLabel.text = entry!.notes
            notesLabel.sizeToFit()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
