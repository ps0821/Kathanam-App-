//
//  TextToSpeechView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI
import AVFoundation

struct TextToSpeechView: View {
    @State private var text = ""
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            Text("Enter text to speak")
                .font(.title2)
                .bold()
            
            TextField("Type something...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Speak") {
                speakText(text)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
        }
        .padding()
    }
    
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}

#Preview {
    TextToSpeechView()
}
