//
//  ViewController.swift
//  Deals
//
//  Created by admin on 7/27/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var boolValueButton = false
    
    var arrayUser = [PasswordUser]()
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatPasswordText: UITextField!
    
    @IBOutlet weak var acessButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         var arrayTexts = [emailText,passwordText,repeatPasswordText]
        
         hiddenKeyboard(arrayTexts)
    }
    
    func hiddenKeyboard(_ arrayText:[Any]) {
        
        for  i in arrayText {
            if i is UITextField {
                var aTransform = i as! UITextField
                aTransform.resignFirstResponder()
            }
        }
    }
    
    
    
    @IBAction func isEneblead(_ sender: Any) {
        
        if boolValueButton == false {
            passwordText.isSecureTextEntry = true
            repeatPasswordText.isSecureTextEntry = true
            boolValueButton = true
        } else {
            passwordText.isSecureTextEntry = false
            repeatPasswordText.isSecureTextEntry = false
            boolValueButton = false
        }
        
    }
    
    @IBAction func isHidden(_ sender: Any) {
        
        if switchButton.isOn == true {
            repeatPasswordText.isHidden = false
        } else {
            repeatPasswordText.isHidden = true
        }
     
    }
    

}

