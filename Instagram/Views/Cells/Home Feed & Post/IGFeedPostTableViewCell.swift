//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Amr Hossam on 19/07/2021.
//

import UIKit
import SDWebImage
import AVFoundation

final class IGFeedPostTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostTableViewCell"
   
    private var player: AVPlayer?
    private var playerLayer:AVPlayerLayer = AVPlayerLayer()
    
    private let postImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    public func configure(with post: UserPost) {
        // configure the cell
        
        
        postImageView.image = #imageLiteral(resourceName: "testImage")
        return
        
        
//        switch post.postType {
//        case .photo:
//            // show iamge
//            postImageView.sd_setImage(with: post.postUrl, completed: nil)
//
//        case .video:
//            // load and play video
//            player = AVPlayer(url: post.postUrl)
//            playerLayer.player = player
//            playerLayer.player?.volume = .zero
//            playerLayer.player?.play()
//
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
}
