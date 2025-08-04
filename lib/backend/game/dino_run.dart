// import 'package:flame/collisions.dart';
// import 'package:flame/game.dart';
// import 'package:flame/components.dart';
// import 'package:flame/effects.dart';
// import 'package:flutter/material.dart';

// // Callback function type for when the game ends
// typedef GameOverCallback = void Function();
// // Callback function type for size changes
// typedef SizeChangeCallback = void Function(double size);
// // Callback function type for timer updates
// typedef TimerUpdateCallback = void Function(int timeLeft);

// class DinoGame extends FlameGame with HasCollisionDetection {
//   DinoGame(
//       {required this.onGameOver,
//       required this.onSizeChange,
//       required this.onTimerUpdate});

//   final GameOverCallback onGameOver;
//   final SizeChangeCallback onSizeChange;
//   final TimerUpdateCallback onTimerUpdate;
//   late Dino dino;
//   late Timer obstacleTimer;
//   double dinoInitialSize = 50.0;
//   bool isGameOver = false;
//   double debugTimer = 0;
//   int currentTimeLeft = 40;
//   bool obstacleSpawned = false;

//   @override
//   Color backgroundColor() => Colors.white;

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     add(dino = Dino(
//         position: Vector2(size.x / 4, size.y - 70),
//         size: Vector2.all(dinoInitialSize)));
//     dino.onSizeChange = onSizeChange;

//     // Set up the timer to add obstacles when time is running out
//     resetObstacleTimer();
//   }

//   void resetObstacleTimer() {
//     obstacleTimer = Timer(1.0, onTick: _checkAndAddObstacle, repeat: true);
//     obstacleTimer.stop();
//     obstacleTimer.start();
//     print('Obstacle timer started - will check every second');
//   }

//   void _checkAndAddObstacle() {
//     // Spawn obstacle when exactly 10 seconds are left
//     if (currentTimeLeft == 10 && !obstacleSpawned) {
//       // Spawn obstacle at the right edge of the game container
//       final spawnPosition = Vector2(size.x - 50, size.y - 50);
//       print('Adding obstacle at position: $spawnPosition');
//       final obstacle = Obstacle(position: spawnPosition);
//       add(obstacle);
//       obstacleSpawned = true;
//     }
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (!isGameOver) {
//       obstacleTimer.update(dt);

//       // Debug: Print timer progress every 5 seconds
//       debugTimer += dt;
//       if (debugTimer >= 5.0) {
//         print(
//             'Game update - dt: $dt, timer progress: ${obstacleTimer.progress}');
//         debugTimer = 0;
//       }

//       // Check for collisions
//       final obstacles = children.whereType<Obstacle>();
//       for (var obstacle in obstacles) {
//         if (dino.toRect().overlaps(obstacle.toRect())) {
//           dino.reduceSize();
//           obstacle.removeFromParent();
//           if (dino.size.x < 10) {
//             // Dino size threshold for game over
//             isGameOver = true;
//             onGameOver();
//           }
//         }
//       }
//     }
//   }

//   void updateTimer(int timeLeft) {
//     currentTimeLeft = timeLeft;
//     onTimerUpdate(timeLeft);

//     // Reset obstacle spawn flag when timer resets (new question)
//     // if (timeLeft == 40) {
//     //   obstacleSpawned = false;
//     // }
//   }

//   void resetObstacleSpawn() {
//     obstacleSpawned = false;
//   }

//   void increaseDinoSize() {
//     if (!isGameOver) {
//       dino.increaseSize();
//       resetObstacleTimer();
//     }
//   }

//   void reduceDinoSize() {
//     if (!isGameOver) {
//       dino.reduceSize();
//       resetObstacleTimer();
//     }
//   }
// }

// class Dino extends SpriteComponent with HasGameReference<DinoGame> {
//   Dino({super.position, super.size}) : super(anchor: Anchor.bottomLeft);

//   late SizeChangeCallback onSizeChange;

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     sprite =
//         await Sprite.load('Dino.png'); // You need to provide a dino.png asset
//     add(RectangleHitbox());
//   }

//   void reduceSize() {
//     final oldHeight = size.y;
//     size.setFrom(size * 0.9); // Reduce size by 10%
//     final heightDifference = oldHeight - size.y;
//     position.y += heightDifference; // Move up by the height difference
//     onSizeChange(size.x);
//   }

//   void increaseSize() {
//     final oldHeight = size.y;
//     size.setFrom(size * 1.1); // Increase size by 10%
//     final heightDifference = size.y - oldHeight;
//     position.y -= heightDifference; // Move down by the height difference
//     onSizeChange(size.x);
//   }
// }

// class Obstacle extends SpriteComponent with HasGameReference<DinoGame> {
//   Obstacle({super.position})
//       : super(size: Vector2.all(50), anchor: Anchor.bottomLeft);

//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     print('Loading obstacle sprite...');
//     try {
//       sprite = await Sprite.load('obstacle.png');
//       print('Obstacle sprite loaded successfully');
//     } catch (e) {
//       print('Error loading obstacle sprite: $e');
//     }
//     add(RectangleHitbox());

//     // Calculate the distance to move to reach dino position
//     // Dino is at size.x / 4, obstacle starts at size.x - 50 (right edge of container)
//     // Need to move from (size.x - 50) to (size.x / 4) in 10 seconds
//     final gameSize = game.size;
//     final dinoX = gameSize.x / 4;
//     final startX = gameSize.x - 50;
//     final distanceToMove = startX - dinoX;

//     print(
//         'Obstacle movement: from $startX to $dinoX, distance: $distanceToMove');

//     // Animate the obstacle to reach dino position in exactly 10 seconds
//     final effect = MoveEffect.by(
//       Vector2(-distanceToMove, 0), // Move exactly to dino position
//       EffectController(duration: 10.0), // 10 seconds to reach dino
//     );
//     add(effect);
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (position.x < -100) {
//       removeFromParent();
//     }
//   }
// }

// dino_run.dart

// dino_run.dart

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// Callbacks remain the same
typedef GameOverCallback = void Function();
typedef SizeChangeCallback = void Function(double size);
typedef TimerUpdateCallback = void Function(int timeLeft);

class DinoGame extends FlameGame
    with HasCollisionDetection, HasGameReference<DinoGame> {
  DinoGame({
    required this.onGameOver,
    required this.onSizeChange,
    required this.onTimerUpdate,
  });

  final GameOverCallback onGameOver;
  final SizeChangeCallback onSizeChange;
  final TimerUpdateCallback onTimerUpdate;

  late Dino dino;
  late Timer gameTimer;
  late Timer cloudSpawnTimer;
  double elapsedTime = 0.0;

  final double questionTimeLimit = 15.0;
  final double obstacleSpawnTime = 10.0;
  final double cloudSpawnInterval = 5.0; // Spawn a cloud every 5 seconds

  bool isGameOver = false;
  bool obstacleHasSpawned = false;
  late final double groundLevel;

  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    groundLevel = size.y - 20.0;

    // Add the track background first (so it appears behind everything)
    add(Track());

    resetGameForNewQuestion();
  }

  void resetGameForNewQuestion() {
    print('Resetting game for new question');
    children.whereType<Obstacle>().forEach((o) => o.removeFromParent());
    //children.whereType<Cloud>().forEach((c) => c.removeFromParent());
    isGameOver = false;
    obstacleHasSpawned = false;
    elapsedTime = 0.0;

    if (children.whereType<Dino>().isEmpty) {
      dino = Dino(
        position: Vector2(
            size.x / 4, groundLevel), // You can adjust this Y position too
        size: Vector2.all(50.0),
      );
      dino.onSizeChange = onSizeChange;
      add(dino);
    } else {
      dino.position = Vector2(
          size.x / 4, groundLevel); // You can adjust this Y position too
    }

    // Create and start new timer
    gameTimer = Timer(1.0, onTick: _onTick, repeat: true)..start();

    // Start cloud spawning timer
    cloudSpawnTimer =
        Timer(cloudSpawnInterval, onTick: _spawnCloud, repeat: true)..start();

    onTimerUpdate(questionTimeLimit.toInt());
    print('Game reset completed, timer started');
  }

  void _spawnCloud() {
    if (!isGameOver) {
      // Spawn cloud from the right edge of the game container
      final random = Random();
      final cloudY = random.nextDouble() * (size.y * 0.4) +
          (size.y * 0.1); // Random Y position in upper 40% of screen
      final spawnPosition =
          Vector2(size.x + 50, cloudY); // Start just outside right edge

      add(Cloud(position: spawnPosition));
    }
  }

  void _onTick() {
    // Increment elapsed time by 1 second (since timer ticks every 1 second)
    elapsedTime += 1.0;
    final currentTime = questionTimeLimit - elapsedTime;
    onTimerUpdate(currentTime.toInt());

    // Debug print to see what's happening
    // print(
    //     'Timer tick: elapsedTime=$elapsedTime, currentTime=$currentTime, obstacleSpawnTime=$obstacleSpawnTime, obstacleHasSpawned=$obstacleHasSpawned');

    if (currentTime <= obstacleSpawnTime && !obstacleHasSpawned) {
      print('Spawning obstacle!');
      // Spawn obstacle from the right side of the game container, but inside it
      final spawnPosition = Vector2(size.x - 50, groundLevel);
      add(Obstacle(
          position: spawnPosition, timeToReachDino: obstacleSpawnTime));
      obstacleHasSpawned = true;
    }

    // -- REMOVED: Timer running out no longer ends the game --
    // if (currentTime <= 0) {
    //   endGame();
    // }
  }

  void endGame() {
    if (!isGameOver) {
      isGameOver = true;
      gameTimer.stop();
      cloudSpawnTimer.stop();
      onGameOver();
    }
  }

  @override
  void update(double dt) {
    if (!isGameOver) {
      super.update(dt);
      gameTimer.update(dt);
      cloudSpawnTimer.update(dt);
      // Debug: Print timer progress occasionally
      // if (elapsedTime % 5 < 1) {
      //   // Every ~5 seconds
      //   print('Game update: dt=$dt, elapsedTime=$elapsedTime');
      // }
    }
  }

  // These methods are called by the widget and remain untouched
  void increaseDinoSize() {
    if (!isGameOver) dino.increaseSize();
  }

  void reduceDinoSize() {
    if (!isGameOver) dino.reduceSize();
  }
}

class Dino extends SpriteComponent
    with CollisionCallbacks, HasGameReference<DinoGame> {
  Dino({super.position, super.size}) : super(anchor: Anchor.bottomLeft);

  late SizeChangeCallback onSizeChange;
  late Sprite dinoSprite1;
  late Sprite dinoSprite2;
  bool isFirstSprite = true;

  @override
  Future<void> onLoad() async {
    dinoSprite1 = await Sprite.load('Dino.png');
    dinoSprite2 = await Sprite.load('Dino2.png');
    sprite = dinoSprite1; // Start with first sprite
    add(RectangleHitbox());

    // Start the running animation
    _startRunningAnimation();
    onGameResize(game.size);
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);

    if (sprite == null) return;

    // Set a desired height relative to the screen height
    height = newSize.y / 7;

    // Adjust the width to maintain the sprite's original aspect ratio
    width = sprite!.originalSize.x * height / sprite!.originalSize.y;
  }

  void _startRunningAnimation() {
    // Create a repeating timer to switch sprites every 0.3 seconds
    final animationTimer = Timer(0.3, onTick: () {
      isFirstSprite = !isFirstSprite;
      sprite = isFirstSprite ? dinoSprite1 : dinoSprite2;
    }, repeat: true);

    // Store the timer reference so we can update it
    _animationTimer = animationTimer;
  }

  Timer? _animationTimer;

  @override
  void update(double dt) {
    super.update(dt);
    _animationTimer?.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Obstacle) {
      // -- CHANGED: A collision is now an instant game over --
      game.endGame();
    }
  }

  // This is now only called by the widget for wrong answers
  void reduceSize() {
    final oldHeight = size.y;
    size.setFrom(size * 0.9);
    position.y += oldHeight - size.y;
    onSizeChange(size.x);
    // -- REMOVED: Getting too small no longer ends the game --
  }

  // This is called by the widget for correct answers
  void increaseSize() {
    final oldHeight = size.y;
    size.setFrom(size * 1.1);
    position.y -= size.y - oldHeight;
    onSizeChange(size.x);
  }
}

// Obstacle class does not need any changes
class Obstacle extends SpriteComponent with HasGameReference<DinoGame> {
  final double timeToReachDino;
  Obstacle({required this.timeToReachDino, super.position})
      : super(size: Vector2.all(50), anchor: Anchor.bottomLeft);

  @override
  Future<void> onLoad() async {
    print('Obstacle onLoad called');
    try {
      sprite = await Sprite.load('obstacle.png');
      print('Obstacle sprite loaded successfully');
      add(RectangleHitbox());

      add(MoveToEffect(
        Vector2(game.dino.position.x, position.y),
        EffectController(duration: timeToReachDino),
        onComplete: () {
          print('Obstacle movement completed, removing from parent');
          removeFromParent();
        },
      ));
      print('Obstacle setup completed');
    } catch (e) {
      print('Error loading obstacle sprite: $e');
    }
    onGameResize(game.size);
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);

    if (sprite == null) return;

    // Use the same scaling logic as the Dino for consistency
    height = newSize.y / 7;
    width = sprite!.originalSize.x * height / sprite!.originalSize.y;
  }
}

// class Track extends SpriteComponent with HasGameReference<DinoGame> {
//   Track() : super(anchor: Anchor.bottomLeft);

//   @override
//   Future<void> onLoad() async {
//     sprite = await Sprite.load('Track.png');

//     // Make the track fit exactly inside the game container
//     // Use the full game container dimensions
//     size = Vector2(game.size.x, game.size.y);

//     // Position the track at the top-left corner of the game container
//     position = Vector2.zero();
//   }
//}

class Track extends SpriteComponent with HasGameReference<DinoGame> {
  // We no longer need a special anchor. The default is fine.
  Track();

  // -- NEW: This is the magic number! --
  // Estimate of the track's vertical position within the PNG file (0.0=top, 1.0=bottom).
  // I'm estimating 60%. Adjust this value if the alignment isn't perfect.
  static const double _trackYRatioInImage = 0.50;

  @override
  Future<void> onLoad() async {
    sprite =
        await Sprite.load('Track.png'); // Your new file name is 'Trackdino.png'
    // Set the initial size and position when the game first loads.
    onGameResize(game.size);
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);

    if (sprite == null) return;

    // This part handles the responsive "zooming" from our previous step.
    final scale = max(
        newSize.x / sprite!.originalSize.x, newSize.y / sprite!.originalSize.y);
    size = sprite!.originalSize * scale;

    // -- THIS IS THE KEY TO ALIGNMENT --
    // This calculation shifts the entire image vertically so that the
    // visual track line inside the image aligns with the game's groundLevel.
    position.y = game.groundLevel - (size.y * _trackYRatioInImage);

    // Keep it horizontally centered if it's wider than the screen.
    position.x = (newSize.x - size.x) / 2;
  }
}

class Cloud extends SpriteComponent with HasGameReference<DinoGame> {
  Cloud({super.position}) : super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('BlackCloud.png');

    // Set initial size based on game container
    onGameResize(game.size);

    // Add movement effect - move from right to left across the screen
    final moveDistance = game.size.x + 100; // Move beyond the left edge
    final moveDuration = 8.0; // Take 8 seconds to cross the screen

    add(MoveByEffect(
      Vector2(-moveDistance, 0),
      EffectController(duration: moveDuration),
      onComplete: () {
        removeFromParent(); // Remove cloud when it goes off screen
      },
    ));
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);

    if (sprite == null) return;

    // Scale cloud size relative to screen size
    // Make it responsive but not too large
    final maxWidth = newSize.x * 0.15; // 15% of screen width
    final maxHeight = newSize.y * 0.1; // 10% of screen height

    // Calculate scale to fit within bounds while maintaining aspect ratio
    final scaleX = maxWidth / sprite!.originalSize.x;
    final scaleY = maxHeight / sprite!.originalSize.y;
    final scale = min(scaleX, scaleY);

    size = sprite!.originalSize * scale;
  }
}
