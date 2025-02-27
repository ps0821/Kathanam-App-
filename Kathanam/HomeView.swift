//
//  HomeView.swift
//  Kathanam
//
//  Created by palak seth on 09/02/25.
//
//
import SwiftUI

struct RecentLearning: Identifiable {
    let id = UUID()
    let subject: String
    let title: String
    let progress: String
    let imageName: String // Custom image for each subject
}


struct RecommendedCourse: Identifiable {
    let id = UUID() // Unique identifier
    let subject: String
    let title: String
    let lessons: String
    let imageName: String // Custom image for each subject
}

struct QuickVideo: Identifiable {
    let id = UUID()
    let title: String
    let videoID: String // YouTube Video ID
}

struct QuickVideo2: Identifiable {
    let id = UUID() // Unique identifier
    let title: String
}

struct HomeView: View {
    // Username for the logged-in user
    @State private var username: String = "John Doe"
    
    
    // Example data for sections
    let recentLearnings: [RecentLearning] = [
        RecentLearning(subject: "ASL", title: "Sign Basics", progress: "5/10", imageName: "asl"),
        RecentLearning(subject: "ISL", title: "Cultural Expressions", progress: "7/10", imageName: "isl"),
        RecentLearning(subject: "Autistic", title: "Social Interaction", progress: "8/10", imageName: "autistic"),
    
    ]

    
    let recommendedCourses: [RecommendedCourse] = [
        RecommendedCourse(subject: "ISL", title: "Cultural Expressions", lessons: "7", imageName: "isl"),
        RecommendedCourse(subject: "ASL", title: "Sign Basics", lessons: "5", imageName: "asl"),
        RecommendedCourse(subject: "Autistic", title: "Social Interaction", lessons: "8", imageName: "autistic"),
    ]
    let quickVideos: [QuickVideo] = [
        QuickVideo(title: "25 ASL Signs You Need", videoID: "0FcwzMq4iWg"),
        QuickVideo(title: "20+ Basic Sign", videoID: "v1desDduz5M"),
        QuickVideo(title: "100 Essential ASL Signs", videoID: "stCwx6SXgSA"),
        QuickVideo(title: "Greetings in ASL", videoID: "uKKvNqA9N20")
    ]

    
    let reviseContent: [QuickVideo2] = [
        QuickVideo2(title: "Ace Your Tests"),
        QuickVideo2(title: "Important Topics"),
        QuickVideo2(title: "Revise in 10 Minutes")
    ]
    
    let quizzes: [QuickVideo2] = [
        QuickVideo2(title: "Play Quiz Challenge"),
        QuickVideo2(title: "Practice Tests"),
        QuickVideo2(title: "Interactive Quizzes")
    ]

    
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
                            
                            // MARK: - Recent Learning Section
                            VStack(alignment: .leading, spacing: 10) {
                                sectionTitle("Recent Learning")

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: -50) { // Adjust spacing
                                        ForEach(recentLearnings) { learning in
                                            GeometryReader { proxy in
                                                let scale = calculateScale(proxy: proxy) // 3D Effect
                                                
                                                recentLearningCard(
                                                    subject: learning.subject,
                                                    title: learning.title,
                                                    progress: learning.progress,
                                                    imageName: learning.imageName
                                                )
                                                .scaleEffect(scale) // Apply scaling effect
                                                .animation(.spring(), value: scale) // Animate scaling
                                            }
                                            .frame(width: 320, height: 250) // Ensure consistent card size
                                        }
                                    }
                                    .padding(.horizontal, 15) // Adjust padding for alignment
                                    .padding(.bottom, -40)
                                }
                            }

                            
                            
                            
                           
                            // Quick Videos Section
                            sectionWithHorizontalScroll(
                                title: "Quick Videos",
                                items: quickVideos
                            ) { video in
                                quickVideoCard(video: video)
                            }

                            
                            // Recommended Courses
                            sectionWithHorizontalScroll(
                                title: "Recommended",
                                items: recommendedCourses
                            ) { course in
                                courseCard(subject: course.subject, title: course.title, lessons: course.lessons, imageName: course.imageName)
                            }.padding(.bottom, 20)
                            
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
    
    // MARK: - Recent Learning Card
    func recentLearningCard(subject: String, title: String, progress: String, imageName: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName) // Load the custom image
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(radius: 3)

            Text(subject)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)

            // Progress Bar
            HStack {
                ProgressView(value: Float(progress.split(separator: "/").first!) ?? 0, total: 10)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(height: 8)

                Text(progress)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
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
    func courseCard(subject: String, title: String, lessons: String, imageName: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName) // Load the custom image
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(radius: 3)

            Text(subject)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)

            // Progress Bar
            HStack {
                

                Text(lessons )
                    
                Text("Lessons")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 250)
    }
    
    // MARK: Quick Video Card
    // MARK: - Quick Video Card (YouTube Thumbnails)
    func quickVideoCard(video: QuickVideo) -> some View {
        Button(action: {
            openYouTube(videoID: video.videoID)
        }) {
            VStack {
                // Load YouTube thumbnail
                AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(video.videoID)/hqdefault.jpg")) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 120)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 120)
                }

                Text(video.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 5)
            }
            .frame(width: 200, height: 160)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
    // MARK: - Open YouTube Video
    func openYouTube(videoID: String) {
        let youtubeURL = URL(string: "youtube://\(videoID)")!
        let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)")!

        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL)
        } else {
            UIApplication.shared.open(webURL)
        }
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
    
}
#Preview {
    HomeView()
}
