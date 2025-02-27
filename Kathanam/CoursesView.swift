//
//  CoursesView.swift
//  Kathanam
//
//  Created by palak seth on 16/02/25.
//

import SwiftUI

// MARK: - Course Model
struct Course: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let imageName: String
    let subCourses: [SubCourse]
}

// MARK: - SubCourse Model
struct SubCourse: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

// MARK: - CoursesView
struct CoursesView: View {
    // Example data for courses with sub-courses
    let courses: [Course] = [
        Course(
            title: "Indian Sign Language (ISL)",
            description: "Learn ISL hand gestures and expressions used in India.",
            icon: "hands.sparkles.fill",
            imageName: "isl",
            subCourses: [
                SubCourse(title: "Basic ISL", description: "Learn the fundamental signs and gestures."),
                SubCourse(title: "ISL for Daily Conversation", description: "Common phrases and sentences in ISL."),
                SubCourse(title: "ISL for Professional Use", description: "Using ISL in workplaces and official settings.")
            ]
        ),
        Course(
            title: "American Sign Language (ASL)",
            description: "Learn ASL used in the United States for communication.",
            icon: "hands.and.sparkles.fill",
            imageName: "asl",
            subCourses: [
                SubCourse(title: "Basic ASL", description: "Introduction to essential ASL signs."),
                SubCourse(title: "ASL for Family Communication", description: "Learn signs used in family conversations."),
                SubCourse(title: "Advanced ASL Grammar", description: "Mastering ASL structure and grammar.")
            ]
        ),
        Course(
            title: "Autistic Communication",
            description: "Support for individuals with autism through various communication methods.",
            icon: "person.crop.circle.badge.checkmark",
            imageName: "autistic",
            subCourses: [
                SubCourse(title: "Visual Communication", description: "Using visuals for enhanced communication."),
                SubCourse(title: "Speech Therapy Basics", description: "Speech strategies for autistic individuals."),
                SubCourse(title: "Sensory-Friendly Communication", description: "Adapting communication for sensory needs.")
            ]
        )
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // ✅ Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // ✅ Header Section
                    Text("Courses")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    // ✅ Search Bar
                    searchBar()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // ✅ List of courses with navigation
                            ForEach(courses) { course in
                                NavigationLink(destination: SubCoursesView(subCourses: course.subCourses, courseTitle: course.title)) {
                                    courseCard(course: course)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 20) // Prevent overlap with bottom
                }
            }
        }
    }
    
    // MARK: - Search Bar
    func searchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: .constant(""))
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding()
        .frame(width: 350, height: 45)
        .background(Color.white.opacity(0.5))
        .cornerRadius(10)
        .padding(.horizontal)
    }

    // MARK: - Course Card
    func courseCard(course: Course) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            // ✅ Course Image
            Image(course.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 220)
                .cornerRadius(10)

            // ✅ Course Details
            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(course.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }.padding(.leading, 10)

            // ✅ Navigation Arrow
            HStack {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(width: 350)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

// MARK: - SubCoursesView (Displays Sub-Courses)
struct SubCoursesView: View {
    let subCourses: [SubCourse]
    let courseTitle: String

    var body: some View {
        ZStack {
            // ✅ Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 10) {
                // ✅ Title
                Text("\(courseTitle) - Sub Courses")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top, 20)
                    .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(subCourses) { subCourse in
                            subCourseCard(subCourse: subCourse)
                        }
                    }
                    .padding(.leading)
                }

                Spacer(minLength: 20) // Prevent overlap with bottom
            }
        }
    }

    // MARK: - SubCourse Card
    func subCourseCard(subCourse: SubCourse) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(subCourse.title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(subCourse.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(3)
        }
        .padding()
        .frame(width: 350)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

#Preview {
    CoursesView()
}
