//
//  CustomNavBarPreferenceKeys.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import Foundation
import SwiftUI

//@State private var showBackButton: Bool = true
//@State private var title: String = ""
//@State private var subtitle: String? = nil

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String? = nil
    
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = nextValue()
    }
}

struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
    
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    
    func customNavigationTitle(_ title: String) -> some View {
        preference(key: CustomNavBarTitlePreferenceKey.self, value: title)
    }
    
    func customNavigationSubitle(_ subtitle: String?) -> some View {
        preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
    }
    
    func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
        preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
    }
    
    func customNavBarItems(title: String, subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
        self.customNavigationTitle(title)
            .customNavigationSubitle(subtitle)
            .customNavigationBarBackButtonHidden(backButtonHidden)
    }
}
