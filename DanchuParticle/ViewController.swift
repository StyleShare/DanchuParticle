//
//  ViewController.swift
//  DanchuParticle
//
//  Created by Suyeol Jeon on 17/05/2019.
//  Copyright © 2019 Suyeol Jeon. All rights reserved.
//

import UIKit

private final class Particle: UIImageView {
  var acceleration: CGPoint = .zero
  var velocity: CGPoint = .zero
  var angle: CGFloat = 0 {
    didSet {
      self.transform = CGAffineTransform(rotationAngle: self.angle)
    }
  }
}

final class ViewController: UIViewController {
  private var particles = Set<Particle>()
  private let gravity: CGFloat = 1
  private let friction: CGFloat = 0.8

  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    let displayLink = CADisplayLink(target: self, selector: #selector(frame))
    displayLink.add(to: .current, forMode: .default)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.play()
    self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.play()
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    self.timer?.invalidate()
  }

  private func play() {
    UIImpactFeedbackGenerator(style: .light).impactOccurred()

    let count = Int.random(in: 5...10)
    for _ in 0..<count {
      let view = Particle()
      defer { view.layer.cornerRadius = view.frame.size.height / 2 }
      view.image = UIImage(named: "ic_danchu_gray")?.withRenderingMode(.alwaysTemplate)
      view.tintColor = UIColor(
        red: 1,
        green: 192 / 255,
        blue: 54 / 255,
        alpha: 1
      )
      self.view.addSubview(view)
      self.particles.insert(view)

      let size = CGFloat.random(in: 30...50)
      view.frame.size = CGSize(width: size, height: size)
      view.center.x = self.view.frame.width / 2
      view.center.y = self.view.frame.height / 2
      view.acceleration = CGPoint(
        x: CGFloat.random(in: -30..<30),
        y: CGFloat.random(in: -100..<(-30))
      )
    }
  }

  @objc private func frame(link: CADisplayLink) {
    for view in self.particles {
      view.acceleration.x *= (1 - self.friction)
      view.acceleration.y *= (1 - self.friction)
      view.velocity.x += view.acceleration.x
      view.velocity.y += view.acceleration.y + self.gravity
      view.center.x += view.velocity.x
      view.center.y += view.velocity.y
      view.angle += view.velocity.x / 10

      if view.frame.minY > self.view.frame.height {
        self.particles.remove(view)
        view.removeFromSuperview()
      }
    }
  }
}
