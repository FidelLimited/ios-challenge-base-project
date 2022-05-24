# CardNumberField

A SwiftUI component to handle a **card number** user input.

## Getting the card number

Just initialize the component with a closure which will send you the card number. Example code:

```swift
CardNumberField(onCardNumberInput: { cardNumber in
    print(cardNumber)
})
```
