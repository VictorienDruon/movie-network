//
//  ReviewForm.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 19/03/2024.
//

import SwiftUI

struct ReviewForm: View {
    @EnvironmentObject var viewModel: ShowViewModel

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Button("", systemImage: "xmark") {}
                    .labelStyle(.iconOnly)
                    .buttonStyle(StyledButton(.secondaryOutline, .small, iconOnly: true))
                    .hidden()
                Spacer()
                Headline("Review")
                Spacer()
                Button("Close", systemImage: "xmark") {
                    viewModel.showingReviewForm = false
                }
                .labelStyle(.iconOnly)
                .buttonStyle(StyledButton(.secondaryOutline, .small, iconOnly: true))
            }

            HStack {
                ForEach(1 ... 5, id: \.self) { i in
                    Button("Rate \(i)", systemImage: "star.fill") {
                        if i == viewModel.rating {
                            viewModel.rating = 0
                        } else {
                            viewModel.rating = i
                        }
                    }
                    .labelStyle(.iconOnly)
                    .font(.title)
                    .foregroundStyle(i <= viewModel.rating ?? 0 ? .accent9 : .neutral4)
                }
            }

            TextField("Your review", text: $viewModel.comment, axis: .vertical)
                .lineLimit(3 ... 6)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(.neutral4)
                }

            Spacer()

            Button("Submit") {
                if let rating = viewModel.rating {
                    viewModel.reviewShow(rating: rating, comment: viewModel.comment)
                }
            }
            .buttonStyle(StyledButton(.primary, .full))
        }
        .padding()
        .presentationDetents([.medium])
        .interactiveDismissDisabled()
    }
}

#Preview {
    VStack {}
        .sheet(isPresented: .constant(true)) {
            ReviewForm()
        }
        .environmentObject(ShowViewModel(for: sampleMovie.toShow()))
}
