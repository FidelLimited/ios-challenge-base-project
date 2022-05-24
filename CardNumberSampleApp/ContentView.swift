//
//  ContentView.swift
//  CardNumberSampleApp
//
//  Created by Corneliu Chitanu on 25/04/22.
//

import SwiftUI
import CardNumberField

struct ContentView: View {
    
    var body: some View {
        CardNumberField(onCardNumberInput: { cardNumber in
            print(cardNumber)
        })
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
