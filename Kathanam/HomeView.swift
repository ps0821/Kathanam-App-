//
//  HomeView.swift
//  Kathanam
//
//  Created by palak seth on 09/02/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header
                HStack {
                    Image("logo") // Add your logo here
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.leading, 10)

                    Spacer()

                    VStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white)
                        Text("Gaju")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                    }
                    .padding(.trailing, 10)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)

                // Dashboard title
                Text("Dashboard")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 10)

                Spacer()

                // Cards
                VStack(spacing: 20) {
                    dashboardCard(title: "Your Courses:")
                    dashboardCard(title: "Course Progress:")
                    dashboardCard(title: "Assessment Progress:")
                }

                Spacer()

                // Bottom Navigation Bar
                HStack {
                    bottomNavItem(icon: "house.fill", text: "Home")
                    bottomNavItem(icon: "book.fill", text: "Courses")
                    bottomNavItem(icon: "arrow.2.circlepath", text: "Conversion")
                    bottomNavItem(icon: "gearshape.fill", text: "Settings")
                }
                .frame(height: 70)
                .background(Color.green)
            }
        }
    }

    // Function for Dashboard Card
    func dashboardCard(title: String) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 100)
            .overlay(
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.blue)
                    .padding(.leading, 20),
                alignment: .leading
            )
            .shadow(radius: 5)
    }

    // Function for Bottom Navigation Item
    func bottomNavItem(icon: String, text: String) -> some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HomeView()
}
