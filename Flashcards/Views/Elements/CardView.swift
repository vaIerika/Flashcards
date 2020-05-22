//
//  CardView.swift
//  Flashcards
//
//  Created by Valerie 👩🏼‍💻 on 13/05/2020.
//

import SwiftUI

struct CardView: View {
    
    // Accessibility
    @Environment(\.accessibilityEnabled) var accessibilityEnabled // VoiceOver enable
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var card: Card
    let retryIncorrectCards: Bool
    private var shouldResetPosition: Bool {
        offset.width < 0 && retryIncorrectCards // incorrect answer && retry incorrect cards
    }
    var removal: ((_ isCorrect: Bool) -> Void)?
    
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
                        .font(.largeTitle)
                        .foregroundColor(Color.black)
                } else {
                    Text(card.question)
                        .font(.custom("OpenSans-Regular", size: 22))
                        .foregroundColor(Color.grapeDrk)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.custom("OpenSans-Regular", size: 20))
                            .foregroundColor(Color.goldDrk)
                            .padding(.top, 12)
                    }
                }
            }
            .padding(25)
            .multilineTextAlignment(.center)
            .lineLimit(3)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(dragGesture())
        .onTapGesture { self.isShowingAnswer.toggle() }
        .animation(.spring())
    }
    
    func getBackgroundColor(offset: CGSize) -> Color {
        if offset.width > 0 {
            return .forestBrt
        }
        
        if offset.width < 0 {
            return .magenta
        }
        
        return .white
    }
    
    func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                self.offset = gesture.translation
                
                // warm up taptic engine to avoid delay when playing haptic feedback
                self.feedback.prepare()
            }
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                
                    // remove the card
                    if self.offset.width > 0 {
                        self.feedback.notificationOccurred(.success)
                    } else {
                        self.feedback.notificationOccurred(.error)
                    }
                    
                    self.removal?(self.offset.width > 0)
                    
                    if self.shouldResetPosition {
                        self.isShowingAnswer = false
                        self.offset = .zero
                    }
                } else {
                
                    // restore the card
                    self.offset = .zero
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
