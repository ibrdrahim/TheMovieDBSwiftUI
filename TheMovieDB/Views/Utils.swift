//
//  Utils.swift
//  TheMovieDB
//
//  Created by ibrahim on 26/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import SwiftUI

extension Color {
    static let fontTheme = Color("FontColor")
    static let mainTheme = Color("MainThemeColor")
    static let viewTheme = Color("ViewColor")
}

struct ThemedTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.fontTheme)
    }
}

extension View {
    func ThemedText() -> ModifiedContent<Self, ThemedTextModifier> {
        return modifier(ThemedTextModifier())
    }
}
