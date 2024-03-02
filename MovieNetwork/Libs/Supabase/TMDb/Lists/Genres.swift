//
//  Genres.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 29/02/2024.
//

import Foundation

struct GenreInfo: Equatable, Identifiable, Hashable {
    var id: String { name }
    var name: String
    var emoji: String
    var movieId: Int?
    var tvSeriesId: Int?
    var backdropPath: URL?
    var backdropUrl: (BackdropImageSize) -> URL? {
        { size in imageUrl(path: self.backdropPath, size: .backdrop(size)) }
    }
}

let genresList = [
    GenreInfo(name: "Action", emoji: "💥", movieId: 28, tvSeriesId: 10759, backdropPath: URL(string: "/cCKU3EuiSKt6xsOI6gg5kiFgZYm.jpg")!),
    GenreInfo(name: "Romance", emoji: "💞", movieId: 10749, tvSeriesId: nil, backdropPath: URL(string: "/qJeU7KM4nT2C1WpOrwPcSDGFUWE.jpg")!),
    GenreInfo(name: "Drama", emoji: "👥", movieId: 18, tvSeriesId: 18, backdropPath: URL(string: "/hO7KbdvGOtDdeg0W4Y5nKEHeDDh.jpg")!),
    GenreInfo(name: "Adventure", emoji: "🏔️", movieId: 12, tvSeriesId: 10759, backdropPath: URL(string: "/35z8hWuzfFUZQaYog8E9LsXW3iI.jpg")!),
    GenreInfo(name: "Comedy", emoji: "😄", movieId: 35, tvSeriesId: 35, backdropPath: URL(string: "/o8ZS811VjYbBi4pRYwILLdWCVey.jpg")!),
    GenreInfo(name: "Kids", emoji: "👦", movieId: nil, tvSeriesId: 10762, backdropPath: URL(string: "/9531Jp42H0ppRXjkxxgCulnQNZp.jpg")!),
    GenreInfo(name: "Animation", emoji: "🖍️", movieId: 16, tvSeriesId: 16, backdropPath: URL(string: "/hGGC9gKo7CFE3fW07RA587e5kol.jpg")!),
    GenreInfo(name: "Family", emoji: "👨‍👩‍👧‍👦", movieId: 10751, tvSeriesId: 10751, backdropPath: URL(string: "/n9wlAmb4vEgZHghtqsXXj95PocJ.jpg")!),
    GenreInfo(name: "Sci-Fi", emoji: "🌌", movieId: 878, tvSeriesId: 10765, backdropPath: URL(string: "/ibNvtkuptjWB2KfE6Odt7wszKSQ.jpg")!),
    GenreInfo(name: "Documentary", emoji: "🏞️", movieId: 99, tvSeriesId: 99, backdropPath: URL(string: "/2Nwbv0hrN8sThLvgooShcPqmFrO.jpg")!),
    GenreInfo(name: "Crime", emoji: "🕵🏻‍♂️", movieId: 80, tvSeriesId: 80, backdropPath: URL(string: "/dwMZ8BW1tUp69baogSrcTAumKuR.jpg")!),
    GenreInfo(name: "War", emoji: "🪖", movieId: 10752, tvSeriesId: 10768, backdropPath: URL(string: "/ddIkmH3TpR6XSc47jj0BrGK5Rbz.jpg")!),
    GenreInfo(name: "Fantasy", emoji: "🐲", movieId: 14, tvSeriesId: 10765, backdropPath: URL(string: "/aRKQdF6AGbhnF9IAyJbte5epH5R.jpg")!),
    GenreInfo(name: "Mystery", emoji: "🔍", movieId: 9648, tvSeriesId: 9648, backdropPath: URL(string: "/4HWAQu28e2yaWrtupFPGFkdNU7V.jpg")!),
    GenreInfo(name: "Horror", emoji: "👹", movieId: 27, tvSeriesId: nil, backdropPath: URL(string: "/qi6Edc1OPcyENecGtz8TF0DUr9e.jpg")!),
    GenreInfo(name: "Western", emoji: "🤠", movieId: 37, tvSeriesId: 37, backdropPath: URL(string: "/rZTj8AVUD8IKlsVF0XFoZzPG2dv.jpg")!),
    GenreInfo(name: "History", emoji: "🏛️", movieId: 36, tvSeriesId: nil, backdropPath: URL(string: "/eHMh7kChaNeD4VTdMCXLJbRTzcI.jpg")!),
    GenreInfo(name: "Thriller", emoji: "🔪", movieId: 53, tvSeriesId: nil, backdropPath: URL(string: "/9b3uxqcjkmay20EBZZj1KVow0r5.jpg")!),
]
