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

    private static let headerFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE,\nd MMM yyyy"
        return formatter
    }()

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Top 1/3 – current date
                    Text(Self.headerFormatter.string(from: Date()))
                        .font(.system(size: 60, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .frame(height: geometry.size.height / 3)

                    // Bottom 2/3 – task list and input
                    VStack {
                        List {
                            ForEach(tasks, id: \.self) { task in
                                Text(task)
                            }
                            .onDelete { indexSet in
                                tasks.remove(atOffsets: indexSet)
                            }
                            // Row for adding a new task
                            HStack {
                                TextField("Add New task", text: $newTask)
                                    .textFieldStyle(.roundedBorder)
                                Spacer()
                                Button {
                                    addTask()
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                }
                                .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        .background(Color.cyan)
                    }
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
