//
//  TMDbSampleData.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

let sampleMovie = Movie(
    id: 693134,
    title: "Dune: Part Two",
    overview: "Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.",
    posterPath: URL(string: "/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg"),
    backdropPath: URL(string: "/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg")
)

let sampleTvSeries = TVSeries(
    id: 60573,
    name: "Silicon Valley",
    overview: "In the high-tech gold rush of modern Silicon Valley, the people most qualified to succeed are the least capable of handling success. Partially inspired by Mike Judge’s own experiences as a Silicon Valley engineer in the late ‘80s, Silicon Valley is an American sitcom that centers around six programmers who are living together and trying to make it big in the Silicon Valley.",
    posterPath: URL(string: "/dc5r71XI1gD4YwIUoEYCLiVvtss.jpg"),
    backdropPath: URL(string: "/cPItMV5Y7e5Vev0ggtyI1XnLnep.jpg")
)

let samplePerson = Person(
    id: 115440,
    name: "Sydney Sweeney",
    gender: .female,
    profilePath: URL(string: "/qYiaSl0Eb7G3VaxOg8PxExCFwon.jpg")!
)

let sampleCastMember = CastMember(
    id: 111678,
    creditID: "52fb8dd9c3a36819bf3b8d59",
    name: "Thomas Middleditch",
    character: "Richard Hendriks",
    profilePath: URL(string: "/2c15BQ6DWSiDSBTRjvdsp8X4AAe.jpg"),
    order: 0
)

let sampleCrewMember = CrewMember(
    id: 17403,
    creditID: "5372f1a6c3a3681502000909",
    name: "Mike Judge",
    job: "Director",
    department: "Acting",
    profilePath: URL(string: "/8jEumAVtJ23rE4XZ0YrvVKAUKjk.jpg")
)
