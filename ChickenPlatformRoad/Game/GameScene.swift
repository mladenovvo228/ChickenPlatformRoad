import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    weak var gameProtocol: GameSceneProtocol?
    
    var level: Int
    private var score = 0
    var platform = SKSpriteNode()
    
    
    var finish = false
    
    var sphereNode = SKSpriteNode()
    
    init(level: Int = 1) {
        self.level = level
        super.init(size: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        size = view.bounds.size
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        createBackground(in: self)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.createSphere()
            self.startPlatformSpawner()
        }
        
        start()
    }
    
    func createBackground(in scene: SKScene) {
        let bg = SKSpriteNode(imageNamed: "bg_game")
        bg.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        bg.size = CGSize(width: scene.size.width, height: scene.size.height)
        bg.zPosition = -2
        
        scene.addChild(bg)
    }
    
    func createSphere() {
        sphereNode = SKSpriteNode(imageNamed: gameProtocol!.selectedEgg())
        sphereNode.setScale(0.3)
        sphereNode.name = "sphere"
        sphereNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sphereNode.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        sphereNode.physicsBody?.categoryBitMask = Categories.sphereCategory
        sphereNode.physicsBody?.contactTestBitMask = Categories.starCategory | Categories.finishCategory
        sphereNode.physicsBody?.collisionBitMask = Categories.platformCategory
        sphereNode.physicsBody?.affectedByGravity = true
        sphereNode.physicsBody?.allowsRotation = false
        sphereNode.physicsBody?.linearDamping = 1.0
        sphereNode.color = .blue
        addChild(sphereNode)
    }
    
    func startPlatformSpawner() {
        let spawnAction = SKAction.run { [weak self] in
            self?.spawnPlatform()
        }
        let delayAction = SKAction.wait(forDuration: 5)
        let sequence = SKAction.sequence([spawnAction, delayAction])
        
        // запускаємо з ключем, щоб можна було гарантовано зупинити/перезапустити
        removeAction(forKey: "spawner")
        run(SKAction.repeatForever(sequence), withKey: "spawner")
    }
    
    func spawnPlatform() {
        platform = SKSpriteNode(imageNamed: "platform")
        platform.setScale(0.1)
        platform.zPosition = 1
        
        let scaledPlatformSize = platform.calculateAccumulatedFrame().size
        let platformWidth = scaledPlatformSize.width
        
        let xPosition = CGFloat.random(in: platformWidth / 2...(size.width - platformWidth / 2))
        platform.position = CGPoint(x: xPosition, y: size.height)
        
        platform.physicsBody = SKPhysicsBody(rectangleOf: platform.size)
        platform.physicsBody?.isDynamic = false
        platform.physicsBody?.categoryBitMask = Categories.platformCategory
        platform.physicsBody?.collisionBitMask = Categories.sphereCategory
        
        let star = SKSpriteNode(imageNamed: "coin")
        star.setScale(0.6)
        star.position = CGPoint(x: 0, y: platform.position.y - (platform.position.y / 2))
        star.zPosition = 1
        star.name = "star"
        star.physicsBody = SKPhysicsBody(circleOfRadius: star.size.width / 2)
        star.physicsBody?.isDynamic = false
        star.physicsBody?.categoryBitMask = Categories.starCategory
        
        if !finish {
            platform.addChild(star)
        }
        addChild(platform)
        
        let moveDown = SKAction.moveBy(x: 0, y: -size.height, duration: 10.0)
        let remove = SKAction.removeFromParent()
        platform.run(SKAction.sequence([moveDown, remove]))
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        
        let dx = touchLocation.x - previousLocation.x
        let dy = touchLocation.y - previousLocation.y
        
        let impulse = CGVector(dx: dx * (0.036 - CGFloat(level) * 0.001), dy: dy * (0.036 - CGFloat(level) * 0.001))
        sphereNode.physicsBody?.applyImpulse(impulse)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if mask == (Categories.sphereCategory | Categories.starCategory) {
            if let starNode = (contact.bodyA.categoryBitMask == Categories.starCategory
                               ? contact.bodyA.node : contact.bodyB.node) {
                starNode.removeFromParent()
                score += 1
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.gameProtocol?.didUpdateScore(self.score)
                }
            }
        }
        
        if mask == (Categories.sphereCategory | Categories.finishCategory) {
            isPaused = true
            DispatchQueue.main.async { [weak self] in
                self?.gameProtocol?.didCompleteLevel()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if sphereNode.parent != nil && sphereNode.position.y < -50 && !isPaused {
            isPaused = true
            DispatchQueue.main.async { [weak self] in
                self?.gameProtocol?.didFailLevel()
            }
        }
    }
    
    func createFinish() {
        let label = SKSpriteNode(imageNamed: "text")
        label.setScale(0.4)
        
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        addChild(label)
        
        let sequence = SKAction.sequence([.fadeOut(withDuration: 1), .fadeIn(withDuration: 1), .fadeOut(withDuration: 1), .fadeIn(withDuration: 1), .fadeOut(withDuration: 1), .removeFromParent()])
        label.run(sequence)
        
        let path = CGMutablePath()
        let dashLength: CGFloat = 10
        let gapLength: CGFloat = 5
        var currentX: CGFloat = 0
        while currentX < size.width {
            path.move(to: CGPoint(x: currentX, y: size.height - 50))
            path.addLine(to: CGPoint(x: min(currentX + dashLength, size.width), y: size.height - 50))
            currentX += dashLength + gapLength
        }
        
        let line = SKShapeNode(path: path)
        line.position.y = -size.height / 12
        line.strokeColor = .white
        line.lineWidth = 3
        
        line.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: size.height - 30), to: CGPoint(x: size.width, y: size.height - 30))
        line.physicsBody?.isDynamic = false
        line.physicsBody?.categoryBitMask = Categories.finishCategory
        line.physicsBody?.contactTestBitMask = Categories.sphereCategory
        addChild(line)
    }
    
    var label = SKLabelNode()
    func start() {
        label = SKLabelNode(text: "Ready?")
        label.name = "start"
        label.fontName = "NeonAi"
        label.fontSize = 40
        label.fontColor = .white
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        addChild(label)
        
        let sequence = SKAction.sequence([
            .fadeOut(withDuration: 1),
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1),
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1),
            .removeFromParent()
        ])
        
        label.run(sequence)
    }
    
    func levelComplete(level: Int) {
        UserDefaults.standard.set(true, forKey: "level\(level)")
    }
    
    
    
    func resetGame() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        isPaused = false
        level += 1
        finish = false
        
        score = 0
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.gameProtocol?.didUpdateScore(0)
        }
        
        removeAllActions()
        removeAction(forKey: "spawner")
        removeAllChildren()
        
        createBackground(in: self)
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.createSphere()
            self.startPlatformSpawner()
            
        }
        start()
    }
    
    
}

struct Categories {
    static let sphereCategory: UInt32 = 0x1 << 0
    static let starCategory: UInt32 = 0x1 << 1
    static let platformCategory: UInt32 = 0x1 << 2
    static let finishCategory: UInt32 = 0x1 << 3
}
