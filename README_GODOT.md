# GENESIS - Godot Project Setup

## 🚀 Getting Started

### 1. Install Godot
**Ubuntu (Snap):**
```bash
sudo snap install godot --classic
```

**Ubuntu (Flatpak):**
```bash
sudo apt install flatpak
flatpak install flathub org.godotengine.Godot
```

### 2. Open Project
1. Start Godot
2. Click "Import"
3. Navigate to this folder
4. Select `project.godot`
5. Click "Open"

## 📁 Project Structure

```
genesis_godot/
├── project.godot              # Main configuration
├── scenes/main/main.tscn      # Main scene
├── scripts/singletons/        # Global managers
│   ├── network_manager.gd     # Multiplayer
│   └── game_state.gd          # Game state
├── assets/                    # Models, textures, sounds
├── export_presets/           # Build configurations
└── README_GODOT.md           # This file
```

## 🎮 Core Systems

### Network Manager
- Handles multiplayer connections
- Server/client architecture
- Player management

### Game State Manager
- Tracks game mode (World Building, Game Master, Player)
- Manages player data
- World persistence

## 🛠️ Development Workflow

### 1. Test Locally
- Open project in Godot
- Press F5 to run
- Test basic movement and UI

### 2. Add Features
1. Create new scenes in `scenes/`
2. Write scripts in `scripts/`
3. Add assets to `assets/`

### 3. Multiplayer Testing
1. Run one instance as host
2. Run another as client (different port)
3. Test connection

## 🔧 Next Steps

### Immediate:
1. [ ] Create basic player controller
2. [ ] Implement simple UI
3. [ ] Test multiplayer connection
4. [ ] Add basic world objects

### Short-term:
1. [ ] World building tools
2. [ ] Game Master dashboard
3. [ ] NPC system
4. [ ] Quest system

## 📚 Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
- [Multiplayer Tutorial](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html)

## 🐛 Troubleshooting

### Common Issues:

1. **"Scene not found"**
   - Check file paths in `main.tscn`
   - Ensure all referenced files exist

2. **Multiplayer not working**
   - Check firewall settings
   - Verify IP addresses
   - Test on localhost first

3. **Script errors**
   - Check Godot version (4.2+ required)
   - Verify GDScript syntax

## 🤝 Contributing

1. Follow existing code structure
2. Add comments for complex logic
3. Test changes before committing
4. Update documentation

---

**Happy developing!** 🎮🚀