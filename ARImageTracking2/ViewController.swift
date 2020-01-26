//
//  ViewController.swift
//  ARImageTracking2
//
//  Created by Prem Nalluri on 08/12/19.
//  Copyright © 2019 AgathsyaTechnologies. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = .showFeaturePoints
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/SceneKit Scene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.accessibilityElementsHidden = true
        guard let container = sceneView.scene.rootNode.childNode(withName: "container", recursively: false) else {
                return
                }
        container.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
       
//        if #available(iOS 13.0, *) {
//            configuration.frameSemantics.insert(.personSegmentationWithDepth)
//        } else {
//            // Fallback on earlier versions
//        }
       // let configuration = ARImageTrackingConfiguration()
        guard let arImages = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources-3", bundle: nil) else{return}
               configuration.detectionObjects = arImages
        
        // Run the view's session
        sceneView.session.run(configuration)
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.planeDetection = .horizontal
        //sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
       
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let node = SCNNode()
//
//        return node
//    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        sceneView.scene.accessibilityElementsHidden = false
        guard anchor is ARObjectAnchor else {return}
                    guard let container = sceneView.scene.rootNode.childNode(withName: "container", recursively: false) else {
                        return
                    }
            container.removeFromParentNode()
            node.addChildNode(container)
            let effectnode = SKEffectNode()
        
            container.isHidden = false
                    let videoURL = Bundle.main.url(forResource: "video1", withExtension: "mov")
                    let videoPlayer = AVPlayer(url: videoURL!)
                    let videoScene = SKScene(size: CGSize(width: 720, height: 1280))
                    let videoNode = SKVideoNode(avPlayer: videoPlayer)
                    videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
                    videoNode.size = videoScene.size
                    videoNode.yScale = -1
                    videoNode.play()
            
                    videoScene.addChild(videoNode)
                    guard let video = container.childNode(withName: "video", recursively: true)else{return}
                    video.geometry?.firstMaterial?.diffuse.contents = videoScene

        
    }
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard anchor is ARImageAnchor else {return}
//        //container
//        guard let container = sceneView.scene.rootNode.childNode(withName: "container", recursively: false) else {
//            return
//        }
//        container.removeFromParentNode()
//        node.addChildNode(container)
//        container.isHidden = false
//        let videoURL = Bundle.main.url(forResource: "Movie", withExtension: "mp4")
//        let videoPlayer = AVPlayer(url: videoURL!)
//        let videoScene = SKScene(size: CGSize(width: 720, height: 1280))
//        let videoNode = SKVideoNode(avPlayer: videoPlayer)
//        videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
//        videoNode.size = videoScene.size
//        videoNode.yScale = -1
//        videoNode.play()
//
//        videoScene.addChild(videoNode)
//        guard let video = container.childNode(withName: "video", recursively: true)else{return}
//        video.geometry?.firstMaterial?.diffuse.contents = videoScene
//
//
//    }
    
}
