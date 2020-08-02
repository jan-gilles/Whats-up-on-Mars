//
//  NavigationController+Helpers.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 09.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import UIKit

extension UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()

        appearance.backgroundEffect = UIBlurEffect(style: .systemMaterialDark)
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]

        navigationBar.standardAppearance = appearance

        navigationBar.tintColor = .white
    }

}


