//
//  TimerView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct TimerView: View {
    enum Style { case variable, fixed }
    
    let timeRemaining: Int
    let style: Style
    let displayLeadingZeros: Bool = true
    
    var body: some View {
        Group {
            if style == .variable {
                variableStyleTimer()
            } else {
                 fixedStyleTimer()
            }
        }
        .fontOpenSansModifier(.footnote)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        
    }
    
    private func variableStyleTimer() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Remaining time: ")
                Text("\(timeRemaining)")
                    .fontHerculanum(.title1, color: .goldDrk)
            }
            
            // avoid jitter
            HStack {
                Text("Remaining time: \(String(repeating: "0", count: String(timeRemaining).count))")
                    .hidden()
                    .frame(height: 0)
            }
        }
    }
    
    private func fixedStyleTimer() -> some View {
        HStack(spacing: 0) {
            Text("Time: ")
            ForEach(0..<GameView.maxTimerDigits, id: \.self) { i in

                VStack(alignment: .center) {
                    timerDigitText(for: i)
                        .fontHerculanum(.title1, color: .goldDrk)
                    
                    // avoid jitter
                    Text("0")
                        .hidden()
                        .frame(height: 0)
                }
            }
        }
    }
    
    private func timerDigitText(for position: Int) -> Text {
        let stringTimeRemaining = Array(String(timeRemaining))
        let index = position - (GameView.maxTimerDigits - stringTimeRemaining.count)

        if index >= 0 {
            return Text(String(stringTimeRemaining[index]))
        }
        
        if displayLeadingZeros {
            return Text("0")
                .foregroundColor(Color.white.opacity(0.2))
        }
        
        return Text("")
    }
}


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: 89, style: .fixed)
        TimerView(timeRemaining: 89, style: .variable)
    }
}
