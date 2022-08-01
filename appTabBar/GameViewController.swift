//
//  GameViewController.swift
//  prueba
//
//  Created by german on 28/05/22.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var tipoLuz = 0
    var contador = 0
    var isRestarted = false
    var isLightRestart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        let scene = SCNScene()
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // CAMARA
        
        let camara = SCNCamera()
        let camaraNode = SCNNode()
        camaraNode.camera = camara

        //ESTABLECER POSICION DE LA CAMARA, usar el valor de los slider's
        camaraNode.position = SCNVector3(x: 0, y: 0, z: 15.0)
        
        
        // LUZ
       let luz = SCNLight()
        
        luz.type = SCNLight.LightType.omni
        
        luz.spotInnerAngle = 30.0
        
        luz.spotOuterAngle = 70.0
        luz.castsShadow = false
        
        let luzNode = SCNNode()
        luzNode.light = luz
        
        luzNode.position = SCNVector3(x: 3.0, y: 10.0, z: 10.0)
        let geometriaPlano = SCNPlane(width: 30, height: 30)
        let planoNodo = SCNNode(geometry: geometriaPlano)
        
        planoNodo.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0)
        planoNodo.position = SCNVector3(x: 0, y: -2.0, z: 0)
        
        
        // MATERIAL
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.black
        
        let material2 = SCNMaterial()
        material2.diffuse.contents = UIColor.black
        
        geometriaPlano.materials = [material]
        
        switch tipoLuz {
        case 0:
            isLightRestart = false
            luz.type = SCNLight.LightType.omni
            break
        case 1:
            luz.type = SCNLight.LightType.ambient
            break
        case 2:
            luz.type = SCNLight.LightType.directional
            break
        case 3:
            luz.type = SCNLight.LightType.IES
            break
        case 4:
            luz.type = SCNLight.LightType.probe
            break
        case 5:
            luz.type = SCNLight.LightType.spot
            break
        case 6:
            isLightRestart = true
            luz.type = SCNLight.LightType.area
            break
        default:
            break
        }
        
        luz.intensity = 2000
        
        switch contador {
        case 0:
            scnView.scene!.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
            isRestarted = false
            dibujaFiguras(scene:scene, luzNode:luzNode, camaraNode:camaraNode, planoNodo:planoNodo)
            break
        case 1:
            scnView.scene!.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
            dibujaFigurasCirculo(scene:scene, luzNode:luzNode, camaraNode:camaraNode, planoNodo:planoNodo)
            break
        case 2:
            scnView.scene!.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
            animacionCirculo(scene:scene, luzNode:luzNode, camaraNode:camaraNode, planoNodo:planoNodo)
        case 3:
            scnView.scene!.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
            isRestarted = true
            animacionGrid(scene:scene, luzNode:luzNode, camaraNode:camaraNode, planoNodo:planoNodo)
        
        default:
            break
        }
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        let button = UIButton(type: .system)
        button.tintColor = UIColor.red
        button.titleLabel?.font = UIFont(name: "San Francisco", size: 24)
        button.setTitle("Figura          🔵", for: .normal)
        
        button.sizeToFit()
        button.addTarget(self, action: #selector(didPressNext), for: .touchUpInside)
        button.center.x = 350
        button.frame.origin.y = 40
        scnView.addSubview(button)
        
        let button2 = UIButton(type: .system)
        button2.tintColor = UIColor.red
        button2.titleLabel?.font = UIFont(name: "San Francisco", size: 24)
        button2.setTitle("Iluminación 🔆", for: .normal)
        button2.sizeToFit()
        button2.addTarget(self, action: #selector(didPressIlum), for: .touchUpInside)
        button2.center.x = 350
        button2.frame.origin.y = 80
        scnView.addSubview(button2)
        
        
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    func dibujaFigurasCirculo(scene:SCNScene, luzNode: SCNNode, camaraNode: SCNNode, planoNodo: SCNNode)
    {
        
     
        
        let geometries = [SCNSphere(radius: 1.0),
                          SCNPlane(width: 1.0, height: 1.5),
                          SCNBox(width: 1.0, height: 1.5, length: 2.0, chamferRadius: 0.0),
                          SCNPyramid(width: 2.0, height: 1.5, length: 1.0),
                          SCNCylinder(radius: 1.0, height: 1.5),
                          SCNCone(topRadius: 0.5, bottomRadius: 1.0, height: 1.5),
                          SCNTorus(ringRadius: 1.0, pipeRadius: 0.2),
                          SCNTube(innerRadius: 0.5, outerRadius: 1.0, height: 1.5),
                          SCNCapsule(capRadius: 0.5, height: 2.0)]
        
        
        
        var angle:Float = 0.0
        let radius:Float = 4.0
        let angleIncrement:Float = Float.pi * 2.0 / Float(geometries.count)

        for index in 0..<geometries.count {

            let hue:CGFloat = CGFloat(index) / CGFloat(geometries.count)
            let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)

            let geometry = geometries[index]
            geometry.firstMaterial?.diffuse.contents = color

            let node = SCNNode(geometry: geometry)

            let x = radius * cos(angle)
            let z = radius * sin(angle)

            node.position = SCNVector3(x: x, y: 0.0, z: z)

            scene.rootNode.addChildNode(node)

            angle += angleIncrement
        }
        
        
        //AGREGAMOS LOS NODOS
        scene.rootNode.addChildNode(luzNode)
        scene.rootNode.addChildNode(camaraNode)
//        scene.rootNode.addChildNode(cuboNodo)
        scene.rootNode.addChildNode(planoNodo)
        
    }
    
    
    func animacionGrid(scene:SCNScene, luzNode: SCNNode, camaraNode: SCNNode, planoNodo: SCNNode)
    {
        

        // FUNCION
        
        func sinFunction(x: Float,z: Float) -> Float {
           return 0.2 * sin(x * 5 + z * 3) + 0.1 * cos(x * 5 + z * 10 + 0.6) + 0.05 * cos(x * x * z)
        }

        func squareFunction(x: Float,z: Float) -> Float {
           return x * x + z * z
        }

        let gridSize = 25

        let capsuleRadius:CGFloat = 1.0 / CGFloat(gridSize - 1)
        let capsuleHeight:CGFloat = capsuleRadius * 4.0

        var z:Float = Float(-gridSize + 1) * Float(capsuleRadius)

        for row in 0..<gridSize {
          var x:Float = Float(-gridSize + 1) * Float(capsuleRadius)
          for column in 0..<gridSize {
              let capsule = SCNCapsule(capRadius: capsuleRadius, height: capsuleHeight)

              let hue = CGFloat(abs(x * z))
              let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)

              capsule.firstMaterial?.diffuse.contents = color

              let capsuleNode = SCNNode(geometry: capsule)

            scene.rootNode.addChildNode(capsuleNode)

              capsuleNode.position = SCNVector3Make(x, 0.0, z)

            let y = CGFloat(squareFunction(x: x,z: z))
              //let y = CGFloat(sinFunction(x, z: z))

            let moveUp = SCNAction.moveBy(x: 0, y: y, z: 0, duration: 1.0)
            let moveDown = SCNAction.moveBy(x: 0, y: -y, z: 0, duration: 1.0)

              let sequence = SCNAction.sequence([moveUp,moveDown])

            let repeatedSequence = SCNAction.repeatForever(sequence)

              capsuleNode.runAction(repeatedSequence)

              x += 2.0 * Float(capsuleRadius)

          }

          z += 2.0 * Float(capsuleRadius)
        }
        
        camaraNode.position = SCNVector3(x: 0, y: 0, z: 5.0)
        
        scene.rootNode.addChildNode(luzNode)
        scene.rootNode.addChildNode(camaraNode)
        scene.rootNode.addChildNode(planoNodo)
    }
    
    func animacionCirculo(scene:SCNScene, luzNode: SCNNode, camaraNode: SCNNode, planoNodo: SCNNode)
    {
        
        
        let sphere = SCNSphere(radius: 2.0)
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        let sphereNode = SCNNode(geometry: sphere)

        scene.rootNode.addChildNode(sphereNode)

        
        let moveUp = SCNAction.moveBy(x: 0.0, y: 1.0, z: 0.0, duration: 1.0)
        let moveDown = SCNAction.moveBy(x: 0.0, y: -1.0, z: 0.0, duration: 1.0)
        let sequence = SCNAction.sequence([moveUp,moveDown])
        let repeatedSequence = SCNAction.repeatForever(sequence)
        sphereNode.runAction(repeatedSequence)
        
        
        // AGREGAMOS LOS NODOS
        scene.rootNode.addChildNode(luzNode)
        scene.rootNode.addChildNode(camaraNode)
//        scene.rootNode.addChildNode(cuboNodo)
        scene.rootNode.addChildNode(planoNodo)
    }
    
    func dibujaFiguras(scene:SCNScene, luzNode: SCNNode, camaraNode: SCNNode, planoNodo: SCNNode)
    {
        
        
        
        let geometries = [SCNSphere(radius: 1.0),
                          SCNPlane(width: 1.0, height: 1.5),
                          SCNBox(width: 1.0, height: 1.5, length: 2.0, chamferRadius: 0.0),
                          SCNPyramid(width: 2.0, height: 1.5, length: 1.0),
                          SCNCylinder(radius: 1.0, height: 1.5),
                          SCNCone(topRadius: 0.5, bottomRadius: 1.0, height: 1.5),
                          SCNTorus(ringRadius: 1.0, pipeRadius: 0.2),
                          SCNTube(innerRadius: 0.5, outerRadius: 1.0, height: 1.5),
                          SCNCapsule(capRadius: 0.5, height: 2.0)]
        
        
        
        var x:Float = -10
        for index in 0..<geometries.count {

          let hue:CGFloat = CGFloat(index) / CGFloat(geometries.count)
          let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)

          let geometry = geometries[index]
          geometry.firstMaterial?.diffuse.contents = color

          let nodo = SCNNode(geometry: geometry)
            nodo.position = SCNVector3(x: x, y: 0.0, z: -15.0)

          scene.rootNode.addChildNode(nodo)

            x += 2.5
            
            let constraint = SCNLookAtConstraint(target: nodo)
//
            constraint.isGimbalLockEnabled = true
//            camaraNode.constraints = [constraint]
//
//            luzNode.constraints = [constraint]
        }
    
        
        //AGREGAMOS LOS NODOS
        scene.rootNode.addChildNode(luzNode)
        scene.rootNode.addChildNode(camaraNode)
//        scene.rootNode.addChildNode(cuboNodo)
        scene.rootNode.addChildNode(planoNodo)
    }
    
    @objc func didPressNext (sender: UIButton!, scene:SCNScene, luzNode: SCNNode, camaraNode: SCNNode, planoNodo: SCNNode) {
        if(isRestarted == true){
            contador = 0
        }else{
            contador += 1
        }
        viewDidLoad()
    }
    
    @objc func didPressIlum (sender: UIButton!, scene:SCNScene, luzNode: SCNNode, camaraNode: SCNNode, planoNodo: SCNNode) {
        if(isLightRestart == true){
            tipoLuz = 0
        }else{
            tipoLuz += 1
        }
        viewDidLoad()
    }
    

}
