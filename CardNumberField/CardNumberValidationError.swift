//
//  CardNumberValidationError.swift
//  CardNumberField
//
//  Created by Corneliu Chitanu on 26/04/22.
//

import Foundation

enum CardNumberValidationError {
    case notValid, notSupported
    
    var errorMessage: String {
        switch self {
        case .notValid: return "Your card number is not valid"
        case .notSupported: return "Your card number is not yet supported"
        }
    }
}
