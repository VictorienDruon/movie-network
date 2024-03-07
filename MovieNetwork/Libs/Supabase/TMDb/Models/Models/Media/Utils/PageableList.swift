//
//  PageableList.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 04/03/2024.
//

import Foundation

typealias MediaPageableList = PageableListResult<Media>
typealias MoviePageableList = PageableListResult<Movie>
typealias TVSeriesPageableList = PageableListResult<TVSeries>
typealias PersonPageableList = PageableListResult<Person>

struct PageableListResult<Result: Codable & Identifiable & Equatable & Hashable>: Codable, Equatable, Hashable {
    let page: Int?
    let results: [Result]
    let totalResults: Int?
    let totalPages: Int?

    init(
        page: Int? = 1,
        results: [Result],
        totalResults: Int? = 0,
        totalPages: Int? = 0
    ) {
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
}
