//
//  CardNumberField.swift
//  
//
//  Created by Corneliu Chitanu on 25/04/22.
//

import SwiftUI
import Combine

/**
 A component to handle a card number input.
 */
public struct CardNumberField: View {
    
    public typealias CardNumberInputHandler = (_ cardNumber: String) -> Void
    
    @State private var cardNumber: String = "" {
        didSet {
            cardNumberInputHandler?(cardNumber)
        }
    }
    @State private var cardNumberValidationError: CardNumberValidationError?
    
    private var cardNumberInputHandler: CardNumberInputHandler?
    private let placeholder = "Your card number"
    private let formattedCardNumberMaxCharacters = 19
    
    /**
     Creates a component to handle card number input.
    
     - Parameters:
        - onCardNumberInput: a closure that will send the card number, as the user types it. This is an *optional* parameter.
     */
    public init(onCardNumberInput: CardNumberInputHandler?) {
        self.cardNumberInputHandler = onCardNumberInput
    }
    
    public var body: some View {
        let cardNumberInputBinding = Binding(get: {
            return self.formattedCardNumber(for: self.cardNumber)
        }, set: { string in
            let cardNumberValue = self.cardNumberValue(from: string)
            if cardNumberValue != self.cardNumber {
                self.cardNumber = cardNumberValue
            }
        })
        return VStack(alignment: .leading, spacing: 4) {
            TextField(placeholder, text: cardNumberInputBinding)
                .onReceive(Just(cardNumberInputBinding), perform: { output in
                    limit(cardNumberInputBinding, formattedCardNumberMaxCharacters)
                })
                .keyboardType(.decimalPad)
                .padding()
                .border(.black)
            if let error = cardNumberValidationError {
                Label(error.errorMessage, systemImage: "bolt.fill")
                    .foregroundColor(.red)
                    .font(.caption)
                    .frame(alignment: .leading)
            }
        }
    }
    
    private func formattedCardNumber(for value: String) -> String {
        let regex: NSRegularExpression

        do {
            regex = try NSRegularExpression(pattern: "(\\d{1,4})(\\d{1,4})?(\\d{1,4})?(\\d{1,4})?", options: NSRegularExpression.Options())
        } catch {
            fatalError("Error when creating regular expression: \(error)")
        }
        
        let matches = regex.matches(in: value, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, value.count))
        var result = [String]()
        
        matches.forEach {
            for i in 1..<$0.numberOfRanges {
                let range = $0.range(at: i)
                
                if range.length > 0 {
                    result.append(NSString(string: value).substring(with: range))
                }
            }
        }
        
        return result.joined(separator: " ")
    }
    
    private func limit(_ binding: Binding<String>, _ limit: Int) {
        if (binding.wrappedValue.count > limit) {
            binding.wrappedValue = String(binding.wrappedValue.prefix(limit))
        }
    }

    private func cardNumberValue(from string: String) -> String {
        let valueWithoutSpaces = string.replacingOccurrences(of: " ", with: "")
        return valueWithoutSpaces
    }
}

struct CardNumberField_Previews: PreviewProvider {
    static var previews: some View {
        CardNumberField { cardNumber in
            print(cardNumber)
        }
    }
}
