//
//  Gradients.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 09/04/2024.
//

import Foundation
import SwiftUI

func djb2(str: String) -> UInt32 {
    var hash: UInt32 = 5381
    for char in str.utf8 {
        hash = (hash &* 33) ^ UInt32(char)
    }
    return hash
}

func getGradientColorsFromId(_ id: UUID) -> (from: Color, to: Color) {
    let hash = djb2(str: id.uuidString)

    let color1 = colors[Int(hash % UInt32(colors.count))]
    let color2 = colors[Int((hash &* 2) % UInt32(colors.count))]

    return (from: Color(hex: color1), to: Color(hex: color2))
}

private let colors = [
    0xec1d1d, 0xed382c, 0xec5844, 0xe65b3c, 0xe2592d, 0xed7440, 0xec7735, 0xea7e30, 0xe28126, 0xec8b19,
    0xe29829, 0xe3a225, 0xecb423, 0xe5c03a, 0xe7cd45, 0xebd834, 0xe8e022, 0xe1e43a, 0xd6e52e, 0xd0e83d,
    0xbfe42c, 0xb5e331, 0xa4e220, 0xabed41, 0x8ce31d, 0x92e43f, 0x80e82e, 0x73e22f, 0x64e328, 0x71e549,
    0x5ded3a, 0x44e22a, 0x4eed41, 0x40ed3d, 0x2fec37, 0x37e649, 0x2feb4d, 0x2deb57, 0x20e056, 0x45eb7d,
    0x38e37d, 0x3ae88a, 0x24e589, 0x40e6a0, 0x3ce9ab, 0x1de9ac, 0x24ebbb, 0x1be5c0, 0x28e2cc, 0x3fefe4,
    0x22eded, 0x42e0ea, 0x26d1e8, 0x2fc6e7, 0x36c0eb, 0x34b2e8, 0x28a6ed, 0x3d9fe5, 0x3293ec, 0x1e79e5,
    0x337ae4, 0x1f63e6, 0x3264e4, 0x4266e6, 0x2c4ae4, 0x1b2fea, 0x2b32e6, 0x3834e9, 0x3122e4, 0x5239e8,
    0x431ae7, 0x511de4, 0x5c1ce3, 0x7634e2, 0x8533ed, 0x8e2fec, 0x9930eb, 0xab43eb, 0xb23ce9, 0xb72ce7,
    0xc328ea, 0xd13aea, 0xe142ef, 0xe03be3, 0xe643df, 0xe74ad8, 0xe730ca, 0xe538bf, 0xe126ad, 0xe548b0,
    0xeb2d9f, 0xe32e90, 0xec4394, 0xe21e70, 0xe73d7a, 0xed2e67, 0xe91e4e, 0xeb3d5c, 0xe53b4f, 0xe62d38
]
