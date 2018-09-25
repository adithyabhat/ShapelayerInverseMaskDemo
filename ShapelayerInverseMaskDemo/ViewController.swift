//
//  ViewController.swift
//  ShapelayerInverseMaskDemo
//
//  Created by Bhat, Adithya H (external - Project) on 25/09/18.
//  Copyright © 2018 Bhat, Adithya H (external - Project). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var overlayView: OverlayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.alpha = 0
        overlayView.delegate = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell")
        
        guard let customCell = cell as? CustomCell else {
            fatalError("CustomCell not found")
        }
        customCell.contentLabel.text = "Cell \(indexPath.row)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else {
            return
        }
        
        //Animate in overlay view
        UIView.animate(withDuration: 0.3) { [weak overlayView] in
            overlayView?.alpha = 1
        }
        
        //Convert the label from cell coordinate space to the overlay view's coordinate space
        let labelRect = cell.convert(cell.contentLabel.frame, to: overlayView)
        overlayView.mask(rect: labelRect, inverse: true, isRounded: true)
    }
    
}

extension ViewController:OverlayViewDelegate {
    
    func overlayTapped() {
        UIView.animate(withDuration: 0.3,
                       animations: { [weak overlayView] in
                        overlayView?.alpha = 0
        }) { [weak overlayView] (success) in
            overlayView?.clearMask()
        }
    }
    
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
}
