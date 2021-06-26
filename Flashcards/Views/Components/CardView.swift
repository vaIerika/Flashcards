//
//  CardView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct CardView: View {
    /// Accessibility: VoiceOver enable
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var card: Card
    let retryIncorrectCards: Bool
    var removal: ((_ isCorrect: Bool) -> Void)?

    /// incorrect answer && retry incorrect cards
    private var shouldResetPosition: Bool {
        offset.width < 0 && retryIncorrectCards
    }
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                        .opacity(0)
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(getBackgroundColor(offset: offset))
                )
                .shadow(color: Color.grapeDrk.opacity(0.2), radius: 5, x: 2, y: 2)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.question)
                        .fontOpenSansModifier(.largeTitle)
                } else {
                    Text(card.question)
                        .fontOpenSansModifier(.title2)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .fontOpenSansModifier(.title2, color: .goldDrk)
                            .padding(.top, 12)
                    }
                }
            }
            .padding(25)
            .multilineTextAlignment(.center)
            .lineLimit(10)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(dragGesture())
        .onTapGesture { isShowingAnswer.toggle() }
        .animation(.spring())
    }
    
    private func getBackgroundColor(offset: CGSize) -> Color {
        if offset.width > 0 {
            return .forestBrt
        }
        if offset.width < 0 {
            return .magenta
        }
        return .white
    }
    
    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                /// warm up taptic engine to avoid delay when playing haptic feedback
                feedback.prepare()
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    /// remove the card
                    if offset.width > 0 {
                        feedback.notificationOccurred(.success)
                    } else {
                        feedback.notificationOccurred(.error)
                    }
                    
                    removal?(offset.width > 0)
                    
                    if shouldResetPosition {
                        isShowingAnswer = false
                        offset = .zero
                    }
                } else {
                    /// restore the card
                    offset = .zero
                }
            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .example, retryIncorrectCards: false)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
