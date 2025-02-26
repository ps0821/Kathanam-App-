//
//  CoursesView.swift
//  Kathanam
//
//  Created by palak seth on 16/02/25.
//

import SwiftUI

struct Course: Identifiable {
    let id = UUID() // Unique identifier
    let title: String
    let description: String
    let icon: String
    let imageName: String // New property for course image
}

struct CoursesView: View {
    // Example data for courses
    let courses: [Course] = [
        Course(
            title: "Indian Sign Language (ISL)",
            description: "Indian Sign Language (ISL) is used by the deaf community in India. Learn hand gestures and expressions that are crucial for communication.",
            icon: "leaf",
            imageName: "isl" // Replace with your image name
        ),
        Course(
            title: "American Sign Language (ASL)",
            description: "American Sign Language (ASL) is the primary sign language of the United States. Learn essential signs for communication and conversation.",
            icon: "leaf",
            imageName: "asl" // Replace with your image name
        ),
        Course(
            title: "Autistic Communication",
            description: "Autistic communication focuses on supporting individuals with autism through various communication techniques and strategies.",
            icon: "leaf",
            imageName: "autistic" // Replace with your image name
        )
    ]

    @State private var selectedTab: Tab = .courses // To manage tab navigation

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 10) {
                    // MARK: Courses Heading
                    Text("Courses")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 10)

                    // MARK: Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: .constant(""))
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    ScrollView {
                        VStack(spacing: 20) {
                            // List of courses
                            ForEach(courses) { course in
                                courseCard(course: course)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Bottom Navigation Bar
                    bottomNavigationBar()
                }
            }
        }
    }

    // MARK: Course Card
    func courseCard(course: Course) -> some View {
        VStack(alignment: .leading, spacing: 40) {
            // Course image
            Image(course.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)

            // Course details
            VStack(alignment: .leading, spacing: 10) {
                Text(course.title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(course.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3) // Limit description to 3 lines
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }


    // MARK: Bottom Navigation Bar
    func bottomNavigationBar() -> some View {
        ZStack {
            // Gradient background for bottom navigation bar
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.7), Color.green.opacity(100)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .blur(radius: 200) // Add blur to blend the edges smoothly
            .ignoresSafeArea(edges: .bottom) // Extend to the bottom edge of the screen

            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    VStack {
                        Image(systemName: tab.icon)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(tab == selectedTab ? .orange : .gray)

                        Text(tab.title)
                            .font(.system(size: 12))
                            .foregroundColor(tab == selectedTab ? .orange : .gray)
                    }
                    .onTapGesture {
                        selectedTab = tab
                    }
                    Spacer()
                }
            }
            .frame(height: 70) // Maintain a consistent height for the navigation bar
        }
        .frame(height: 70) // Frame wrapping the entire navigation bar
    }
    
}

// MARK: Tab Enum for Bottom Navigation
//enum Tab: CaseIterable {
//    case home, courses, translate, shots, profile
//
//    var title: String {
//        switch self {
//        case .home: return "Home"
//        case .courses: return "Courses"
//        case .translate: return "Translate"
//        case .shots: return "Shots"
//        case .profile: return "Dashboard"
//        }
//    }
//
//    var icon: String {
//        switch self {
//        case .home: return "house.fill"
//        case .courses: return "book.fill"
//        case .translate: return "textformat.size"
//        case .shots: return "play.rectangle.fill"
//        case .profile: return "person.fill"
//        }
//    }
//}

#Preview {
    CoursesView()
}

