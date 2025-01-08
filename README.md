# Godot Steam Multiplayer

A simple multiplayer game template using Godot and Steam networking. This project demonstrates the integration of **Steamworks** for lobby creation, real-time player movement synchronization, and in-game chat functionality.

## Setup

### Requirements:
1. **Godot Engine** (v4.1 / 4.2 / 4.3)
2. **Steam**

### Steps:   
1. **Ensure Steam is Running**:
   - Steam must be running to use Steam features like lobbies and P2P networking.

2. **Set Your Steam AppID**:
   - In the `global.gd` script, set your **Steam AppID** to `480` for testing purposes. You can replace it later with your actual AppID when ready to publish.

3. **Run the Project**:
   - Open the project in Godot or export it and run it.

## Features

- **Create and Join Steam Lobbies**: Up to 4 players in a lobby.
- **Real-Time Player Movement Synchronization**: Player positions are synced between clients.
- **In-Game Chat**: Chat functionality for communication between players.
- **P2P Networking via Steam**: Peer-to-peer networking for real-time multiplayer gameplay.

## How to Play

### Host a Game:
1. Click the **"Host"** button.
2. Share the automatically copied **lobby ID** with other players.

### Join a Game:
1. Enter the **lobby ID** of the host.
2. Click the **"Join"** button.

### Controls:
- **Arrow keys** for player movement.
- Type in the **chat box** to send messages to other players.

## Project Structure

- `global.gd`: Steam initialization and global variables (e.g., Steam ID, username).
- `network.gd`: Handles networking, lobby creation, joining, and P2P communication.
- `main.gd`: The main game scene, UI handling, and lobby management.
- `player.gd`: Manages player movement, position synchronization, and input.

## Dependencies

- **Godot Engine** (v4.1 / 4.2 / 4.3)
- **GodotSteam GDExtension** (compatible with your Godot version)
- **Steam SDK**: Required for Steam integration.
  
## License

This project is licensed under the **MIT License**. See the [LICENSE](./LICENSE) file for more details.
