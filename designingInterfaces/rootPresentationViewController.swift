//
//  rootPresentationViewController.swift
//  designingInterfaces
//
//  Created by Cina Mehrvar on 2015-11-05.
//  Copyright © 2015 Cina Mehrvar. All rights reserved.
//

import UIKit

class RootPresentationViewController: UIViewController {

    let drawerWidthConstant:CGFloat = 240.0
    var leftIsRevealed = false
    var rightIsRevealed = false
    
    
    @IBOutlet weak var centerContainer: UIView!
    @IBOutlet weak var leftContainer: UIView!
    @IBOutlet weak var rightContainer: UIView!
    
    
    @IBOutlet weak var leftContainerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightContainerTrailingContainer: NSLayoutConstraint!
    
    var centerViewController: CentreViewController?
    var leftViewController: LeftViewController?
    var rightViewController: RightViewController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStage()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setStage() {
        rightContainerTrailingContainer.constant = -drawerWidthConstant
        leftContainerLeadingConstraint.constant = -drawerWidthConstant
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func fadeButton(sender: AnyObject) {
        toggleOpenLeftPanelWithCompletion { (complete) -> () in
            
            // if you want anything to happen after the animation occurs
            //self.view.backgroundColor = UIColor.grayColor()
        }
        /*
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            if !self.leftIsRevealed {
                self.rightContainerTrailingContainer.constant = 0
                self.leftContainerLeadingConstraint.constant = 0
            } else {
                self.rightContainerTrailingContainer.constant = -self.drawerWidthConstant
                self.leftContainerLeadingConstraint.constant = -self.drawerWidthConstant
            }
            self.leftIsRevealed = !self.leftIsRevealed
            self.view.layoutIfNeeded()
            }) { (completed) -> Void in
        }
*/
    }
    
    func toggleOpenLeftPanelWithCompletion(completion:(Bool) -> ()) {
        
        var panelOffset:CGFloat = 0
        if self.leftIsRevealed {
            panelOffset = -drawerWidthConstant
        }
        leftIsRevealed = !leftIsRevealed
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.leftContainerLeadingConstraint.constant = panelOffset
            }) {(complete) -> Void in
                completion(complete)
        }
    }
    
    func toggleOpenRightPanelWithCompletion(completion:(Bool) -> ()) {
        
        var panelOffset:CGFloat = 0
        if self.rightIsRevealed {
            panelOffset = -drawerWidthConstant
        }
        rightIsRevealed = !rightIsRevealed
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.rightContainerTrailingContainer.constant = panelOffset
            }) {(complete) -> Void in
                completion(complete)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "leftSegue" {
            guard let navController = segue.destinationViewController as? UINavigationController, left = navController.topViewController as? LeftViewController else {return}
            
            leftViewController = left
            leftViewController?.rootPresentationViewController = self
            
        } else if segue.identifier == "rightSegue" {
            guard let navController = segue.destinationViewController as? UINavigationController, right = navController.topViewController as? RightViewController else {return}
            
            rightViewController = right
            rightViewController?.rootPresentationViewController = self
            
        } else if segue.identifier == "centerSegue" {
            guard let navController = segue.destinationViewController as? UINavigationController, center = navController.topViewController as? CentreViewController else {return}
            
            centerViewController = center
            centerViewController?.rootPresentationViewController = self
        }
    }
    

}
