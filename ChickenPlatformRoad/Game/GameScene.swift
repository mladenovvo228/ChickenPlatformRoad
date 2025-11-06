import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    var gameProtocol: GameSceneProtocol!
    
    var level: Int
    private var score = 0
    var finish = false
    
    var platform = SKSpriteNode()
    var eggNode = SKSpriteNode()
    var label = SKLabelNode()
    
    init(level: Int = 1) {
        self.level = level
        super.init(size: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setUpGame(to: view)
    }
    
    func setUpGame(to view: SKView) {
        size = view.bounds.size
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        createBackground(in: self)
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.createEgg()
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
    
    func createEgg() {
        eggNode = SKSpriteNode(imageNamed: gameProtocol.selectedEgg())
        eggNode.setScale(0.3)
        eggNode.name = "sphere"
        eggNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        eggNode.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        eggNode.physicsBody?.categoryBitMask = Categories.eggCategory
        eggNode.physicsBody?.contactTestBitMask = Categories.coinCategory | Categories.finishCategory
        eggNode.physicsBody?.collisionBitMask = Categories.platformCategory
        eggNode.physicsBody?.affectedByGravity = true
        eggNode.physicsBody?.allowsRotation = false
        eggNode.physicsBody?.linearDamping = 1.0
        eggNode.color = .blue
        addChild(eggNode)
    }
    
    func startPlatformSpawner() {
        let spawnAction = SKAction.run { [weak self] in
            self?.spawnPlatform()
        }
        let delayAction = SKAction.wait(forDuration: 5)
        let sequence = SKAction.sequence([spawnAction, delayAction])
        
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
        platform.physicsBody?.collisionBitMask = Categories.eggCategory
        
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.setScale(0.6)
        coin.position = CGPoint(x: 0, y: platform.position.y - (platform.position.y / 2))
        coin.zPosition = 1
        coin.name = "star"
        coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width / 2)
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = Categories.coinCategory
        
        if !finish {
            platform.addChild(coin)
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
        eggNode.physicsBody?.applyImpulse(impulse)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if mask == (Categories.eggCategory | Categories.coinCategory) {
            if let eggNode = (contact.bodyA.categoryBitMask == Categories.coinCategory
                               ? contact.bodyA.node : contact.bodyB.node) {
                eggNode.removeFromParent()
                score += 1
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.gameProtocol.didUpdateScore(self.score)
                }
            }
        }
        
        if mask == (Categories.eggCategory | Categories.finishCategory) {
            isPaused = true
            DispatchQueue.main.async { [weak self] in
                self?.gameProtocol.didCompleteLevel(self!.level)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if eggNode.parent != nil && eggNode.position.y < -50 && !isPaused {
            isPaused = true
            DispatchQueue.main.async { [weak self] in
                self?.gameProtocol.didFailLevel()
            }
        }
    }
    
    func createFinish() {
        let mainLabel = SKLabelNode()
        let label = SKLabelNode(text: "Reach to")
        let label2 = SKLabelNode(text: "the top")
        label.fontName = "RubikMonoOne-Regular"
        label.fontSize = 35
        label.fontColor = .white
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        label2.fontName = "RubikMonoOne-Regular"
        label2.fontSize = 35
        label2.fontColor = .white
        label2.position = CGPoint(x: size.width / 2, y: label.position.y - (label.position.y / 5))
        
        mainLabel.addChild(label)
        mainLabel.addChild(label2)
        addChild(mainLabel)
        
        let sequence = SKAction.sequence([.fadeOut(withDuration: 1), .fadeIn(withDuration: 1), .fadeOut(withDuration: 1), .fadeIn(withDuration: 1), .fadeOut(withDuration: 1), .removeFromParent()])
        mainLabel.run(sequence)
        
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
        line.physicsBody?.contactTestBitMask = Categories.eggCategory
        addChild(line)
    }
    
    func start() {
        label = SKLabelNode(text: "Ready?")
        label.name = "start"
        label.fontName = "RubikMonoOne-Regular"
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
    
    func resetGame() {
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        isPaused = false
        level += 1
        finish = false
        
        score = 0
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.gameProtocol.didUpdateScore(0)
        }
        
        removeAllActions()
        removeAction(forKey: "spawner")
        removeAllChildren()
        
        createBackground(in: self)
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            guard let self else { return }
            self.createEgg()
            self.startPlatformSpawner()
            
        }
        start()
    }
    
    
}

struct Categories {
    static let eggCategory: UInt32 = 0x1 << 0
    static let scoreEggCategory: UInt32 = 0x1 << 1
    static let coinCategory: UInt32 = 0x1 << 2
    static let platformCategory: UInt32 = 0x1 << 3
    static let finishCategory: UInt32 = 0x1 << 4
}
