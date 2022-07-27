//
//  LandingController.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation
import UIKit

class LandingController: UIViewController {
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.updateRootViewController()
        }
    }
}

// MARK: - Methods

private extension LandingController {
    func updateRootViewController() {
        AppDelegate.shared.updateRootViewController()
    }
}
