//
//  ContentView.swift
//  Calculator
//
//  Created by Kadir on 24.08.2020.
//

import SwiftUI

struct ContentView: View {
    @State var typedString = "0"
    @State var performingMath = false
    @State var lastOperation: Operation? = nil
    @State var previousNumber: Double = 0
    @State var currentCalculation: Double = 0

    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(typedString)
                        .font(.custom("Arial Rounded MT Bold", size: 60))
                        .lineLimit(2)
                        .padding(.trailing, screen.width * 0.085)
                }
                Divider().background(Color.blue)
                topButtonRow()
                buttonRows(for: ["7", "8", "9"], operation: .multiplication)
                buttonRows(for: ["4", "5", "6"], operation: .substraction)
                buttonRows(for: ["1", "2", "3"], operation: .addition)
                buttonRows(for: ["00", "0", "."], operation: nil)
            }
            .font(.custom("Arial Rounded MT Bold", size: 26))
            .padding(.leading, screen.width * 0.02)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }

    func topButtonRow() -> some View {
        HStack {
            Button(action: {}) {
                Text("")
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
            }
            Button(action: {}) {
                Text("")
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
            }
            Button(action: { reset() }) {
                Text("C")
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
                    .foregroundColor(Color("ClearButton"))
            }
            Button(action: { tapped(operation: .division) }) {
                Text("/")
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
                    .foregroundColor(.red)
            }
        }
    }

    func buttonRows(for numbers: [String], operation: Operation?) -> some View {
        HStack {
            ForEach(numbers, id: \.self) { number in
                Button(action: {
                    tapped(number: number)
                }) {
                    Text(number)
                        .frame(width: screen.width/4.5, height: screen.height * 0.1)
                        .foregroundColor(Color("Numbers"))
                }
            }
            if operation != nil {
                Button(action: { tapped(operation: operation!) }) {
                    Text(operation!.displayedString)
                        .frame(width: screen.width/4.5, height: screen.height * 0.1)
                        .foregroundColor(.red)
                }
            } else {
                Button(action: { showResult() }) {
                    Text("=")
                        .frame(width: screen.width/4.5, height: screen.height * 0.1)
                        .background(Color.red)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .shadow(radius: 10, x: 5, y: 6)
                }
            }
        }
    }

    func tapped(number: String) {
        if number == "0" || number == "00" {
            guard typedString != "0" else { return }
            typedString += number
        } else if number == "." {
            guard typedString != "." else { return }
            typedString += number
        } else {
            if typedString == "0" {
                typedString = number
            } else {
                typedString += number
            }
        }
    }

    func tapped(operation: Operation) {
        if performingMath, let lastOperation = self.lastOperation {
            calculate(for: lastOperation)
        } else {
            previousNumber = Double(typedString) ?? 0
        }
        // started operation
        lastOperation = operation
        typedString = "0"
        performingMath = true
    }

    func calculate(for operation: Operation) {
        let currentNumber = Double(typedString) ?? 0
        switch operation {
        case .addition:
            currentCalculation = previousNumber + currentNumber
        case .substraction:
            currentCalculation = previousNumber - currentNumber
        case .multiplication:
            currentCalculation = previousNumber * currentNumber
        case .division:
            currentCalculation = previousNumber/currentNumber
        }
        previousNumber = currentNumber
        performingMath = false
    }

    func reset() {
        typedString = "0"
        performingMath = false
        currentCalculation = 0
        previousNumber = 0
        lastOperation = nil
    }

    func showResult() {
        guard let lastOperation = lastOperation, performingMath else { return }
        calculate(for: lastOperation)
        typedString = String(currentCalculation)
    }
}

let screen = UIScreen.main.bounds

enum Operation {
    case addition
    case substraction
    case multiplication
    case division

    var displayedString: String {
        switch self {
        case .addition:
            return "+"
        case .substraction:
            return "-"
        case .multiplication:
            return "*"
        case .division:
            return "/"
        }
    }
}
