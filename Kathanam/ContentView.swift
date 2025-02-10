import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Circle with the custom logo inside
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 200, height: 200) // Increased circle size
                            .shadow(radius: 10)

                        // Custom logo
                        Image("logo") // Use the image added to Assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150) // Increased logo size
                            .clipShape(Circle()) // Optional circular clipping
                    }
                    .padding(.top, 50) // Adjusted top padding as needed

                    // Title "KATHANAM"
                    Text("KATHANAM")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.blue)

                    // Subtitle in another language
                    Text("కథనం")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.blue)

                    // Tagline
                    Text("Where Every Sign\nTells a Story.")
                        .font(.system(size: 24))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.top, 40)

                    Spacer()

                    // Get Started Button
                    NavigationLink(destination: LoginRegisterView()) {
                        Text("GET STARTED")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 50)

                    Spacer() // Maintains overall spacing
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

