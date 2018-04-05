//
//  ATSearchForAccountsIntentHandler.swift
//  Extension
//
//  Created by JunYi on 5/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import Intents

class ATSearchForAccountsIntentHandler: NSObject, INSearchForAccountsIntentHandling {
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        let accounts = BankAccount.allAccounts()
        var nickFound = false
        var result: INSpeakableStringResolutionResult?
        var matchedNick = [INSpeakableString]()
        
        if let accountNickname = intent.accountNickname
        {
            for account in accounts
            {
                if accountNickname.isEqual(account.nickname)
                {
                    nickFound = true
                    break
                }
            }
            
            if nickFound
            {
                result = INSpeakableStringResolutionResult.success(with: accountNickname)
            }
            else
            {
                for account in accounts
                {
                    matchedNick.append(account.nickname!)
                }
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
            }
        }
        else
        {
            var matchedNickwithType = [INSpeakableString]()
            var matchedAccount = [INPaymentAccount]()
            
            let accountType = intent.accountType
            for account in accounts {
                print("Checking accountType")
                if accountType == account.accountType {
                    matchedAccount.append(account)
                }
            }
            
            for account in matchedAccount
            {
                matchedNickwithType.append(account.nickname!)
            }
            
            switch matchedNickwithType.count {
            case 2...Int.max:
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNickwithType)
            case 1:
                result = INSpeakableStringResolutionResult.success(with: matchedNickwithType[0])
            case 0:
                for account in accounts {
                    matchedNick.append(account.nickname!)
                }
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
            default:
                return
                }
            }
        completion(result!)
    }
    
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        
        let response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
		response.accounts = BankAccount.allAccounts()
		completion(response)
    }
}
