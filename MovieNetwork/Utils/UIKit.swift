//
//  UIKit.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/02/2024.
//

import Foundation
import UIKit

func configureNavigationAppearance() {
    let serif = UIFontDescriptor.SystemDesign.serif
    let bold = UIFontDescriptor.SymbolicTraits.traitBold
    let textColor = UIColor.neutral11

    let headingDescriptor = UIFontDescriptor
        .preferredFontDescriptor(withTextStyle: .largeTitle)
        .withDesign(serif)!
        .withSymbolicTraits(bold)!
    let heading = UIFont(descriptor: headingDescriptor, size: 0)
    UINavigationBar.appearance().largeTitleTextAttributes = [
        .font: heading,
        .foregroundColor: textColor
    ]

    let titleDescriptor = UIFontDescriptor
        .preferredFontDescriptor(withTextStyle: .body)
        .withDesign(serif)!
        .withSymbolicTraits(bold)!
    let title = UIFont(descriptor: titleDescriptor, size: 0)
    UINavigationBar.appearance().titleTextAttributes = [
        .font: title,
        .foregroundColor: textColor
    ]
}
