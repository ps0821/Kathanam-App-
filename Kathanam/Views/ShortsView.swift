//
//  ShortsView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI

struct ShortsView: View {
    var body: some View {
        VStack {
            Text("Shorts Coming Soon! 🎥")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
            
            Image(systemName: "play.rectangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.orange)
        }
    }
}

#Preview {
    ShortsView()
}
