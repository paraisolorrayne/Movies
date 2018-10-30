//
//  MovieCell.swift
//  Movies
//
//  Created by Lorrayne Paraiso  on 30/10/18.
//  Copyright © 2018 Lorrayne Paraiso. All rights reserved.
//

import UIKit

class MovieTableViewCell : UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var dateReleaseLabel: UILabel!
    @IBOutlet weak var vAnchor: UIView!
    
    private var movieId = 0
    
    // Dynamics
    private var gravity: UIGravityBehavior!
    private var animator: UIDynamicAnimator?
    private var attachment: UIAttachmentBehavior!
    private var dynamicItem: UIDynamicItemBehavior!
    private var push: UIPushBehavior!
    
    var movie: Movie! {
        didSet {
            loadCell()
        }
    }
    
    private func loadCell() {
        
        animateImage()
        
        self.titleLabel.text = movie.title
        
        if let vote = movie.voteAvarage {
            self.voteLabel.text = "Vote Avarage \(vote)"
        } else {
            self.voteLabel.text = "Vote Avarage -"
        }
        self.dateReleaseLabel.text = "\(movie.releaseDate)"
        self.movieId = movie.id
        
        if self.reuseIdentifier == "\(MovieTableViewCell.self)" {
            movie.loadCoverImage { (image) in
                if self.movie.id == self.movieId {
                    self.backgroundImage.image = image
                }
            }
        }
    }
    
    private func animateImage() {
        // Behaviors
        attachment = UIAttachmentBehavior(item: self.backgroundImage, offsetFromCenter: UIOffset(horizontal: 2, vertical: -40), attachedToAnchor: vAnchor.center)
        
        push = UIPushBehavior(items: [self.backgroundImage], mode: .instantaneous)
        push.angle = 0.5
        push.magnitude = 0.15
        
        gravity = UIGravityBehavior(items: [self.backgroundImage])
        
        dynamicItem = UIDynamicItemBehavior(items: [self.backgroundImage])
        dynamicItem.allowsRotation = true
        dynamicItem.elasticity = 0
        dynamicItem.resistance = 1
        
        // Animator
        animator = UIDynamicAnimator(referenceView: self)
        animator?.addBehavior(dynamicItem)
        animator?.addBehavior(gravity)
        animator?.addBehavior(attachment)
        animator?.addBehavior(push)
    }
    
    deinit {
        animator?.removeAllBehaviors()
    }
}

