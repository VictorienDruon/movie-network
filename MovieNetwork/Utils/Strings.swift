//
//  Strings.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/03/2024.
//

import Foundation

func pluralize(_ string: String, from number: Int) -> String {
    if number >= 2 {
        return "\(string)s"
    } else {
        return string
    }
}
