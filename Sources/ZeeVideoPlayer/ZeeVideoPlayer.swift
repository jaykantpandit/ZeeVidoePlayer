// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit
import AVKit
public class ZeeVideoPlayer: UIView {
    private var playerState: PlayerState = .pause
    public weak var delegate: ZeeVideoPlayerDelegate?
    open var url: URL? = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    let seekBar = UISlider()
//    private var playButton = ZeePlayButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
   
    private var playButton = UIButton()

    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupPlayerView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlayerView()
    }
    
    // MARK: - Setup
    
    func center() -> (width: CGFloat, height: CGFloat){
        let centerX = self.frame.width / 2.0
        let centerY = self.frame.height / 2.0
        return(centerX, centerY)
    }
    
    private func setupPlayerButton(){
        self.backgroundColor = .black
        
        playButton = UIButton(type: .system)
        playButton.frame = CGRect(x: self.center().width - 25, y: self.center().height - 25, width: 50, height: 50)
        playButton.layer.cornerRadius = 0.5 * playButton.bounds.size.width
        playButton.layer.backgroundColor = UIColor.white.cgColor
        playButton.layer.masksToBounds = true
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
        self.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupPlayerView() {
        guard let url = url else {return}
        self.setupPlay(url: url)
        setupPlayerButton()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPlayButton))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func showPlayButton(){
        self.playButton.isHidden = false
        visibleConfiguration()
    }
    
    private func visibleConfiguration(){
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            self.playButton.isHidden = true
        }
    }
    
    func setupPlay(url: URL) {
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        self.layer.addSublayer(playerLayer!)
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        player?.replaceCurrentItem(with: item)
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(handleVideoEnd(_:)),
                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)

    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero) // Seek to beginning
    }
    
    // MARK: - Selector Methods
    
    @objc func play(_ sender: UIButton){
        if self.playerState == .pause{
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            playerState = .play
            player?.play()
        }else{
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
            playerState = .pause
            player?.pause()
        }
        
        visibleConfiguration()
    }
    
    @objc func handleVideoEnd(_ notification: Notification) {
        // Handle video ending here (e.g., show a message, replay the video)
        playButton.setImage(UIImage(systemName: "memories"), for: .normal)
        playerState = .pause
        player?.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
        player?.pause()
    }
}
