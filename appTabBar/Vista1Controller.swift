//
//  Vista1Controller.swift
//  appTabBar
//
//  Created by Guest User on 30/05/22.
//

import UIKit
import MorphingLabel


class Vista1Controller: UIViewController {

    
    
    @IBOutlet weak var LabelTitulo: LTMorphingLabel!
    
    @IBOutlet weak var ImageLogo: UIImageView!
    
    @IBOutlet weak var LabelNombre: UILabel!
    
    @IBOutlet weak var LabelProf: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        

        LabelTitulo.center.x = view.center.x // Place it in the center x of the view.
        LabelTitulo.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
        LabelNombre.center.x = view.center.x
        LabelNombre.center.x -= view.bounds.width
        LabelProf.center.x = view.center.x
        LabelProf.center.x -= view.bounds.width
        
        // animate it from the left to the right
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
            self.LabelTitulo.center.x += self.view.bounds.width
              self.view.layoutIfNeeded()
            self.LabelNombre.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            self.LabelProf.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        
        UIView.transition(with: self.ImageLogo,
                                  duration: 2.0,
                                  options: .transitionFlipFromRight,
                                  animations: {
                                    self.ImageLogo.image = UIImage(imageLiteralResourceName: "Logo")
                }, completion: nil)    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

