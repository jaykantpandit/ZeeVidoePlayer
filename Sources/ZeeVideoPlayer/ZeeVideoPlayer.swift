// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import AVKit

public class ZeeVideoPlayer: UIView {
    
    public weak var delegate: ZeeVideoPlayerDelegate?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlayer()
    }
    
    // MARK: - Setup
    
    private func setupPlayer() {
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        self.layer.addSublayer(playerLayer!)
    }
    
    func play(url: URL) {
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        player?.replaceCurrentItem(with: item)
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero) // Seek to beginning
    }
}
