//
//  ContentView.swift
//  Calculator
//
//  Created by Kadir on 24.08.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var typedString = "0"
    @Environment(\.colorScheme) var colorScheme
    
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
                topButtons()
                buttonRows(for: ["7", "8", "9"], operation: .multiplication)
                buttonRows(for: ["4", "5", "6"], operation: .substraction)
                buttonRows(for: ["1", "2", "3"], operation: .addition)
                buttonRows(for: ["00", "0", "."], operation: nil)
            }
            .font(.custom("Arial Rounded MT Bold", size: 26))
            .padding(.leading, screen.width * 0.02)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
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

func buttonRows(for numbers: [String], operation: Operation?) -> some View {
    HStack {
        ForEach(numbers, id: \.self) { number in
            Button(action: {}) {
                Text(number)
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
                    .foregroundColor(.gray)
            }
        }
        if operation != nil {
            Button(action: {}) {
                Text(operation!.displayedString)
                    .frame(width: screen.width/4.5, height: screen.height * 0.1)
                    .foregroundColor(.red)
            }
        } else {
            Button(action: {}) {
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

func topButtons() -> some View {
    HStack {
        Button(action: {}) {
            Text("")
                .frame(width: screen.width/4.5, height: screen.height * 0.1)
        }
        Button(action: {}) {
            Text("")
                .frame(width: screen.width/4.5, height: screen.height * 0.1)
        }
        Button(action: {}) {
            Text("C")
                .frame(width: screen.width/4.5, height: screen.height * 0.1)
                .foregroundColor(Color("ClearButton"))
        }
        Button(action: {}) {
            Text("/")
                .frame(width: screen.width/4.5, height: screen.height * 0.1)
                .foregroundColor(.red)
        }
    }
}
