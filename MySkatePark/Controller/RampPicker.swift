//
//  RampPicker.swift
//  MySkatePark
//
//  Created by Jerry Lai on 2021-01-23.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

import UIKit
import SceneKit

class RampPicker: UIViewController {
    
    var sceneview: SCNView!
    var size:CGSize!
    
    weak var rampPlacerVC: RampPlacerVC!
    
    init(size: CGSize){
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneview = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        view.insertSubview(sceneview, at: 0)
        
        let scene = SCNScene(named: "art.scnassets/ramps.scn")!
        sceneview.scene = scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneview.addGestureRecognizer(tap)
        
        let pipe = Ramp.getPipe()
        Ramp.startRotation(node: pipe)
        scene.rootNode.addChildNode(pipe)
        
        let pyramid = Ramp.getPyramid()
        Ramp.startRotation(node: pyramid)
        scene.rootNode.addChildNode(pyramid)
        
        let quarter = Ramp.getQuarter()
        Ramp.startRotation(node: quarter)
        scene.rootNode.addChildNode(quarter)
        
        
        
        
        preferredContentSize = size
        
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.borderWidth = 3.0
        
    }
    
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer){
        let p = gestureRecognizer.location(in: sceneview)
        let hitResults = sceneview.hitTest(p, options: [:])
        
        if hitResults.count>0 {
            let node = hitResults[0].node
            rampPlacerVC.onRampSelected(node.name!)
            dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
