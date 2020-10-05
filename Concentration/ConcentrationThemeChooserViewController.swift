//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Ishika Mitra on 05/10/20.
//  Copyright © 2020 Ishika Mitra. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    
    let themes = [
        "Sports": "🏀⚾️🏓⚽️🎱🏸🏏🏑🥏",
         "Faces": "😁😇☹️😭😡😱🥰🙂🤢😉",
        "Animals": "🐶🦉🐍🕷🐽🐵🐸🦄🐝",
       
    ]
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
           
        }
    }
 
    
    

}
