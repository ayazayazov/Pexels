//
//  ProfileVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 29/8/24.
//

import UIKit
import AVFoundation
import AVKit

class ProfileVC: UIViewController {
    
    private let videoView: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    private var videoURL: String = "https://videos.pexels.com/video-files/3571264/3571264-sd_426_240_30fps.mp4"
    var player : AVPlayer!
    var avpController = AVPlayerViewController()
    
    func startVideo(videoURL: String) {
        let url = URL(string: videoURL)
        player = AVPlayer(url: url!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = videoView.bounds
//        videoView.layer.addSublayer(playerLayer)
        player.play()
        
        avpController.view.frame.size.height = videoView.frame.size.height

        avpController.view.frame.size.width = videoView.frame.size.width

        self.videoView.addSubview(avpController.view)

        present(avpController, animated: true) {
            self.avpController.player?.play()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        view.addSubview(videoView)
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            videoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            videoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
