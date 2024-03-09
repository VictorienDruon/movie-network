//
//  Dates.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

func getYear(from date: Date) -> String {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    return String(year)
}
