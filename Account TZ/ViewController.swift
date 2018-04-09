//
//  ViewController.swift
//  Account TZ
//
//  Created by JunYi on 5/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import UIKit
import Intents
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        INPreferences.requestSiriAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                print("Authorized")
            default:
                print("Unauthorized")
            }
        }
        
        
//        let accounts = BankAccount.allAccounts().map { $0.nickname! }
//        let accountsNames = NSOrderedSet(array: accounts)
//        INVocabulary.shared().removeAllVocabularyStrings()
//        INVocabulary.shared().setVocabularyStrings(accountsNames, of: .paymentsAccountNickname)
        
        
        INVocabulary.shared().setVocabulary(["ABC Savings", "BNM", "Standard Account", "JKK Investment"], of: .paymentsAccountNickname)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


