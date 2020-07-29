//
//  LoadingController.swift
//  VK
//
//  Created by Антон Васильченко on 09.07.2020.
//  Copyright © 2020 Антон Васильченко. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {

    @IBOutlet weak var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func start(_ sender: UIBarButtonItem) {
        loadingView.startAnimation()
    }
    
    @IBAction func stop(_ sender: UIBarButtonItem) {
        loadingView.stopAnimation()
    }

}
