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
	
	let accounts = BankAccount.allAccounts()
	
//	func resolveAccountType(for intent: INSearchForAccountsIntent, with completion: @escaping (INAccountTypeResolutionResult) -> Void) {
//		if let accountType = intent.accountType as INAccountType?
//		{
//			var resolutionResult: INAccountTypeResolutionResult?
//			var matchedAccounts = [INPaymentAccount]()
//
//			for account in accounts {
//				print ("Resolving AccountType")
//
//				if accountType == account.accountType {
//					matchedAccounts.append(account)
//				}
//
//				print ("AccountType Resolved")
//			}
//
//			switch matchedAccounts.count {
//			case 2...Int.max:
//				resolutionResult = INAccountTypeResolutionResult.success(with: accountType)
//			case 1:
//				resolutionResult = INAccountTypeResolutionResult.success(with: accountType)
//			case 0:
//				resolutionResult = INAccountTypeResolutionResult.notRequired()
//			default:
//				return
//			}
//			completion(resolutionResult!)
//		}
//	}
	
	
	
	
	
	
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Swift.Void) {

        var nickFound = false
        var result: INSpeakableStringResolutionResult
        var matchedNick = [INSpeakableString]()

		if let accountNickname = intent.accountNickname?.spokenPhrase
        {
            for account in accounts
            {
				if accountNickname == (account.nickname?.spokenPhrase.lowercased())
                {
                    nickFound = true
                    break
                }
            }

            if nickFound
            {
				result = INSpeakableStringResolutionResult.success(with: intent.accountNickname!)
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
            case 1...Int.max:
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNickwithType)
//            case 1:
//                result = INSpeakableStringResolutionResult.success(with: matchedNickwithType[0])
            case 0:
                for account in accounts {
                    matchedNick.append(account.nickname!)
                }
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
            default:
                return
                }
            }

        completion(result)
    }
	
	
	
	
	
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
		
		if let accountNickname = intent.accountNickname {
			let response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
			var matchedNick = [INPaymentAccount]()

			for account in accounts {
				if accountNickname.spokenPhrase == account.nickname?.spokenPhrase.lowercased()
				{
					matchedNick.append(account)
				}
			}

			response.accounts = matchedNick
			completion(response)
		}
		else
		{
			let response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
			completion(response)
		}
		
		
		
		
		
		
//		if let accountType = intent.accountType as INAccountType?
//		{
//			var response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
//			var matchedAccounts = [INPaymentAccount]()
//
//			for account in accounts {
//				if accountType == account.accountType {
//					matchedAccounts.append(account)
//				}
//			}
//
//			switch matchedAccounts.count {
//			case 1...Int.max:
//				response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
//				response.accounts = matchedAccounts
//			case 0:
//				for account in accounts {
//					matchedAccounts.append(account)
//				}
//				response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
//				response.accounts = matchedAccounts
//			default:
//				return
//			}
//			completion(response)
//		}
    }
}

