//
//  ConjuntosView.swift
//  appTabBar
//
//  Created by german on 10/06/22.
//


import UIKit

class ConjuntosView: UIViewController {
    
    @IBOutlet weak var segmentedMembresia: UISegmentedControl!

    @IBOutlet weak var segmentedCOps1: UISegmentedControl!
    
    @IBOutlet weak var textConjuntoA: UITextField!
    
    @IBOutlet weak var textConjuntoB: UITextField!
    
    @IBOutlet weak var labelResultado: UILabel!
    
    @IBOutlet weak var buttonSetA: UIButton!
    @IBOutlet weak var buttonSetB: UIButton!
    
    var conjuntoA = Set<String>()
    
    var conjuntoB = Set<String>()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Permite la modificacion de la forma del label
        // Establece el radio de corvatura
        labelResultado.layer.masksToBounds = true
        labelResultado.layer.cornerCurve = .continuous
        labelResultado.layer.cornerRadius = 15.0
        
        
        
        textConjuntoA.layer.masksToBounds = true
        textConjuntoA.layer.cornerCurve = .continuous
        textConjuntoA.layer.cornerRadius = 15.0
        
        textConjuntoA.layer.borderWidth = 2.0
        textConjuntoA.layer.borderColor = #colorLiteral(red: 0.20476776, green: 0.59529979, blue: 0.5743020042, alpha: 1)
        
        textConjuntoB.layer.masksToBounds = true
        textConjuntoB.layer.cornerCurve = .continuous
        textConjuntoB.layer.cornerRadius = 15.0
        
        textConjuntoB.layer.borderWidth = 2.0
        textConjuntoB.layer.borderColor = #colorLiteral(red: 0.20476776, green: 0.59529979, blue: 0.5743020042, alpha: 1)
        
        
        customButton(button: buttonSetA)
        customButton(button: buttonSetB)
        
        segmentedCOps1.isEnabled = false;
        segmentedMembresia.isEnabled = false;

        imageView.isHidden = true;
    
    }
    @IBAction func buttonSetA(_ sender: UIButton) {
        
        conjuntoA.removeAll()
        labelResultado.text = nil
        
        let array = Array(textConjuntoA.text!)
        print(array)
        for elemento in array {
            conjuntoA.insert(String(elemento))
            print(elemento)
        }
        
        textConjuntoA.isEnabled = true
        textConjuntoB.becomeFirstResponder()
        buttonSetB.isEnabled = true
    }
    
    
    @IBAction func buttonSetB(_ sender: UIButton) {
        
        conjuntoB.removeAll()
        labelResultado.text = nil
        
        let array = Array(textConjuntoB.text!)
        for elemento in array {
            conjuntoB.insert(String(elemento))
            print(elemento)
        }
        
        if(!conjuntoA.isEmpty && !conjuntoB.isEmpty)
        {
            segmentedCOps1.isEnabled = true
            segmentedMembresia.isEnabled = true
        }
    }
    
    
    @IBAction func segmentedOps1(_ sender: UISegmentedControl) {
        
        
        
        segmentedMembresia.selectedSegmentIndex = -1
        segmentedMembresia.setNeedsLayout()
        
        switch segmentedCOps1.selectedSegmentIndex {
        case 0:
            setOperations(operation: conjuntoA.union(conjuntoB).sorted())
            imageView.image = UIImage(named: "union-1")
            break
        case 1:
            
            setOperations(operation: conjuntoA.intersection(conjuntoB).sorted())
            imageView.image = UIImage(named: "interseccion")
            break
        case 2:
            setOperations(operation: conjuntoA.symmetricDifference(conjuntoB).sorted())
            imageView.image = UIImage(named: "symmetricDif")
            break
        case 3:
            setOperations(operation: conjuntoA.subtracting(conjuntoB).sorted())
            imageView.image = UIImage(named: "subtracting")
            break
        default:
            labelResultado.text = nil
        }
    }
    
    
    
    @IBAction func segmentedMember2(_ sender: Any) {
        
        segmentedCOps1.selectedSegmentIndex = -1
        segmentedCOps1.setNeedsLayout()
        
        switch segmentedMembresia.selectedSegmentIndex {
        case 0:
            labelResultado.text = nil
            if conjuntoA.isSubset(of: conjuntoB) == true
            {
                labelResultado.text = "A es un subconjunto de B"
            }else
            {
                labelResultado.text = "A NO es un subconjunto de B"
            }
            imageView.isHidden = false
            imageView.image = UIImage(named: "subset")
            break
        case 1:
            labelResultado.text = nil
            if conjuntoA.isSuperset(of: conjuntoB) == true
            {
                labelResultado.text = "A es un superconjunto de B"
            }else
            {
                labelResultado.text = "A NO es un superconjunto de B"
            }
            imageView.isHidden = false
            imageView.image = UIImage(named: "superset")
            
            break
        case 2:
            labelResultado.text = nil
            if conjuntoA.isDisjoint(with: conjuntoB) == true
            {
                labelResultado.text = "A es disjunto de B"
            }else
            {
                labelResultado.text = "A es union de B"
            }
            imageView.isHidden = false
            imageView.image = UIImage(named: "disjoined")
            break
        default:
            break
        }
    }
    func setOperations(operation: [String]){
        // funcion que establece el tipo de operacion de conjuntos
        labelResultado.text = nil
        let unionAB = operation
        labelResultado.text = unionAB.joined(separator:" ")
        imageView.isHidden = false
       
        
    }
    
    
    func customButton(button: UIButton){
        // funcion para cambiar los valores del boton
        button.layer.masksToBounds = true
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 1.5
        button.layer.borderColor = #colorLiteral(red: 0.20476776, green: 0.59529979, blue: 0.5743020042, alpha: 1)
        button.layer.backgroundColor = #colorLiteral(red: 0.20476776, green: 0.59529979, blue: 0.5743020042, alpha: 1)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Cuando cesan los toquess fuera de la pantalla se deshabilitan y resetean los valores
        imageView.isHidden = true
        segmentedCOps1.selectedSegmentIndex = -1
        segmentedMembresia.selectedSegmentIndex = -1
        segmentedCOps1.setNeedsLayout()
        segmentedMembresia.setNeedsLayout()
        labelResultado.text = nil
        segmentedCOps1.isEnabled = false
        segmentedMembresia.isEnabled = false
    }
    
    
}

