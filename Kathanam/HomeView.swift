//
//  HomeView.swift
//  Kathanam
//
//  Created by palak seth on 09/02/25.
//

import SwiftUI

struct RecentLearning: Identifiable {
    let id = UUID() // Unique identifier
    let subject: String
    let title: String
    let progress: String
}

struct RecommendedCourse: Identifiable {
    let id = UUID() // Unique identifier
    let subject: String
    let title: String
    let lessons: String
}

struct QuickVideo: Identifiable {
    let id = UUID() // Unique identifier
    let title: String
}

struct HomeView: View {
    // Username for the logged-in user
    @State private var username: String = "John Doe"
    
    
    // Example data for sections
    let recentLearnings: [RecentLearning] = [
        RecentLearning(subject: "Mathematics", title: "High School Algebra I: Help and Review", progress: "5/10"),
        RecentLearning(subject: "Mathematics", title: "High School Algebra I: Help and Review", progress: "7/10"),
        RecentLearning(subject: "Mathematics", title: "High School Algebra I: Help and Review", progress: "8/10"),
        RecentLearning(subject: "Mathematics", title: "High School Algebra I: Help and Review", progress: "2/10")
    ]
    
    let recommendedCourses: [RecommendedCourse] = [
        RecommendedCourse(subject: "Physics", title: "Fundamentals of Motion", lessons: "8 Lessons"),
        RecommendedCourse(subject: "Physics", title: "Fundamentals of Motion", lessons: "8 Lessons"),
        RecommendedCourse(subject: "Physics", title: "Fundamentals of Motion", lessons: "8 Lessons"),
    ]
    
    let quickVideos: [QuickVideo] = [
        QuickVideo(title: "Short Video 1"),
        QuickVideo(title: "Short Video 2"),
        QuickVideo(title: "Short Video 3"),
        QuickVideo(title: "Short Video 4")
    ]
    
    let reviseContent: [QuickVideo] = [
        QuickVideo(title: "Ace Your Tests"),
        QuickVideo(title: "Important Topics"),
        QuickVideo(title: "Revise in 10 Minutes")
    ]
    
    let quizzes: [QuickVideo] = [
        QuickVideo(title: "Play Quiz Challenge"),
        QuickVideo(title: "Practice Tests"),
        QuickVideo(title: "Interactive Quizzes")
    ]
    
    @State private var selectedTab: Tab = .home // Current tab selection
    
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
                
                VStack(spacing: 0) {
                    // Header
                    headerView()
                    
                    // Scrollable content
                    ScrollView {
                        VStack(spacing: 20) {
                            // Greeting and search bar
                            greetingView()
                            
                            // Recent Learning Section
                            VStack(alignment: .leading, spacing: 10) {
                                sectionTitle("Recent Learning")
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: -100) { // Minimal spacing between cards
                                        ForEach(recentLearnings) { learning in
                                            GeometryReader { proxy in
                                                let scale = calculateScale(proxy: proxy) // Dynamically calculate scale
                                                
                                                recentLearningCard(
                                                    subject: learning.subject,
                                                    title: learning.title,
                                                    progress: learning.progress
                                                )
                                                .scaleEffect(scale) // Apply scaling effect
                                                .animation(.spring(), value: scale) // Animate the scaling
                                            }
                                            .frame(width: 350, height: 300) // Ensure consistent card size
                                        }
                                    }
                                    .padding(.horizontal, 10) // Adjust padding for alignment
                                    .padding(.bottom, -90)
                                }
                                
                            }
                            
                            
                            
                            // Quick Videos Section
                            sectionWithHorizontalScroll(
                                title: "Quick Videos",
                                items: quickVideos
                            ) { video in
                                quickVideoCard(title: video.title)
                            }
                            
                            // Recommended Courses
                            sectionWithHorizontalScroll(
                                title: "Recommended",
                                items: recommendedCourses
                            ) { course in
                                courseCard(subject: course.subject, title: course.title, lessons: course.lessons)
                            }
                            
                            // Revise Section
                            sectionWithVerticalCards(
                                title: "Revise",
                                items: reviseContent
                            ) { content in
                                reviseCard(title: content.title)
                            }
                            
                            // Quizzes Section
                            VStack(alignment: .leading, spacing: 10) {
                                sectionTitle("Quizzes")
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) { // Adjust spacing as needed
                                        ForEach(quizzes) { quiz in
                                            quizCard(title: quiz.title)
                                                .frame(width: 300) // Adjust the width if necessary
                                        }
                                    }
                                    .padding(.horizontal, 10) // Add padding around the stack
                                }
                            }
                            
                        }
                        .padding(.top, 20)
                    }
                    
                    // Bottom Navigation Bar
                    bottomNavigationBar()
                }
            }
            .navigationBarBackButtonHidden(true) // Disable back navigation
        }
        .navigationBarHidden(true)
    }
    
    // MARK: Header View
    func headerView() -> some View {
        HStack {
            Image(systemName: "person.circle.fill") // Profile icon
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            Spacer()
            
            VStack {
                Image(systemName: "bell.fill")
                    .foregroundColor(.white)
                Text("Notifications")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.orange)
    }
    
    // MARK: Greeting View
    func greetingView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hi, \(username)")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("What do you want to learn today?")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: .constant(""))
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
        .padding(.horizontal)
    }
    
    // MARK: Section Title
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.black)
            .padding(.horizontal)
    }
    
    // MARK: Section With Horizontal Scroll
    func sectionWithHorizontalScroll<Item: Identifiable, Content: View>(
        title: String,
        items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items) { item in
                        content(item)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: Section With Vertical Cards
    func sectionWithVerticalCards<Item: Identifiable, Content: View>(
        title: String,
        items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(title)
            
            VStack(spacing: 15) {
                
                ForEach(items) { item in
                    content(item)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: Recent Learning Card
    func recentLearningCard(subject: String, title: String, progress: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "book.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
            
            Text(subject)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            HStack {
                ProgressView(value: Float(progress.split(separator: "/").first!) ?? 0, total: 10)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(height: 10)
                
                Text(progress)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .frame(width: 250)
    }
    
    // MARK: Scaling Logic for Recent Learning Cards
    func calculateScale(proxy: GeometryProxy) -> CGFloat {
        let midX = proxy.frame(in: .global).midX
        let screenMidX = UIScreen.main.bounds.width / 2
        let distance = abs(screenMidX - midX)
        
        // Adjust scaling based on the distance from the center
        let scale = max(1 - (distance / 400), 0.9) // Minimum scale is 0.9
        return scale
    }
    
    
    // MARK: Course Card
    func courseCard(subject: String, title: String, lessons: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
            
            Text(subject)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            Text(lessons)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .frame(width: 200)
    }
    
    // MARK: Quick Video Card
    func quickVideoCard(title: String) -> some View {
        Text(title)
            .font(.system(size: 16))
            .padding()
            .frame(width: 200, height: 120)
            .background(Color.green.opacity(0.2))
            .cornerRadius(10)
            .shadow(radius: 1)
    }
    
    // MARK: Revise Card
    func reviseCard(title: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "note.text")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Revise with Chapter Summary & Important Questions in under 10 minutes.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            // "Start Revision" Button
            Button(action: {
                // Handle the button action here
                print("Start Revision tapped!")
            }) {
                Text("Start Revision")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity) // Make button full-width
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
    
    // MARK: Quiz Card
    func quizCard(title: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "timer")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.pink)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Go head to head with students worldwide.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            // "Play Now" Button
            Button(action: {
                // Handle the button action here
                print("Play Now tapped!")
            }) {
                Text("Play Now")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity) // Make button full-width
                    .background(Color.pink)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.pink.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 1)
        .padding(.bottom, 80)
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
            .blur(radius: 200
) // Add blur to blend the edges smoothly
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
enum Tab: CaseIterable {
    case home, courses, translate, shots, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .courses: return "Courses"
        case .translate: return "Translate"
        case .shots: return "Shots"
        case .profile: return "Dashboard"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .courses: return "book.fill"
        case .translate: return "textformat.size"
        case .shots: return "play.rectangle.fill"
        case .profile: return "person.fill"
        }
    }
}

#Preview {
    HomeView()
}

