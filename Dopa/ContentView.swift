//
//  ContentView.swift
//  Dopa
//
//  Created by Jaskirat Singh on 2025-05-29.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [String] = []
    @State private var newTask: String = ""

    private static let headerWeekdayFormatter: DateFormatter = {
        let f = DateFormatter()
        // Weekday only
        f.dateFormat = "EEEE"
        return f
    }()

    private static let headerRestFormatter: DateFormatter = {
        let f = DateFormatter()
        // Day number, space, month, space, year
        f.dateFormat = "d MMM yyyy"
        return f
    }()

    private static let taskAreaColor = Color(red: 0.0, green: 0.55, blue: 0.85)

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(Self.headerWeekdayFormatter.string(from: Date()))
                            .font(.system(size: 80, weight: .bold))
                        Text(Self.headerRestFormatter.string(from: Date()))
                            .font(.system(size: 40, weight: .bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .frame(height: geometry.size.height / 3)

                    // Bottom 2/3 – task list and input
                    VStack {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(tasks, id: \.self) { task in
                                    HStack {
                                        Text(task)
                                            .foregroundColor(.white)
                                            .padding()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Self.taskAreaColor)
                                    .cornerRadius(8)
                                }

                                if tasks.count < 5 {
                                    HStack {
                                        TextField("Add New task", text: $newTask)
                                            .textFieldStyle(.plain)
                                            .padding()
                                        Button {
                                            addTask()
                                        } label: {
                                            Image(systemName: "plus.circle.fill")
                                                .font(.title2)
                                        }
                                        .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(8)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .background(Color.clear)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .frame(height: geometry.size.height * 2 / 3)
                }
            }
        }
    }

    private func addTask() {
        let trimmed = newTask.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tasks.append(trimmed)
        newTask = ""
    }
}

#Preview {
    ContentView()
}
