//
//  ContentView.swift
//  Calculator
//
//  Created by Kadir on 24.08.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                buttonRows(for: ["7","8","9"], operation: .multiplication)
                buttonRows(for: ["4","5","6"], operation: .substraction)
                buttonRows(for: ["1","2","3"], operation: .addition)
            }
            .font(.custom("Arial Rounded MT Bold", size: 26))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

func buttonRows(for numbers: [String], operation: Operation) -> some View {
    HStack{
        ForEach(numbers, id: \.self) { number in
            Button(action: {}) {
                Text(number)
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
                    .foregroundColor(.gray)
            }
        }
        Button(action: {}) {
            Text(operation.displayedString)
                .frame(width: screen.width/4.5, height: screen.height * 0.1)
                .foregroundColor(.red)
        }
    }
}
