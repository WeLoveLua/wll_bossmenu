# WLL Boss Menu

A modern FiveM boss menu script built with React, TailwindCSS, and Framer Motion animations for seamless player and organization management.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)
![FiveM](https://img.shields.io/badge/FiveM-Compatible-orange.svg)

## 🚀 Features

- **Modern UI**: Built with React 19 and TailwindCSS 4.1
- **Smooth Animations**: Powered by Framer Motion
- **Responsive Design**: Works on all screen sizes
- **Player Management**: Recruit, manage, and organize members
- **Rank System**: Create and manage organizational hierarchy
- **Financial Tracking**: Monitor income and expenses
- **Outfit Management**: Handle organization uniforms
- **Real-time Dashboard**: Live statistics and activity feed

## 📋 Preview

The boss menu includes the following sections:
- **Dashboard**: Overview with statistics and quick actions
- **Players**: Member management and recruitment
- **Ranks**: Hierarchy and permission management
- **Finance**: Financial tracking and transactions
- **Outfits**: Uniform and appearance management
- **Settings**: Configuration and preferences

## 🛠️ Installation

1. **Download the resource**
   ```bash
   git clone https://github.com/your-username/wll_bossmenu.git
   ```

2. **Install UI dependencies**
   ```bash
   cd wll_bossmenu/ui
   npm install
   ```

3. **Build the UI**
   ```bash
   npm run build
   ```

4. **Add to your FiveM server**
   - Copy the `wll_bossmenu` folder to your server's `resources` directory
   - Add `ensure wll_bossmenu` to your `server.cfg`

## 🔧 Development

### UI Development
```bash
cd ui
npm run dev  # Start development server
npm run build  # Build for production
npm run lint  # Run ESLint
```

### Project Structure
```
wll_bossmenu/
├── client/           # Client-side Lua scripts
├── server/           # Server-side Lua scripts
├── shared/           # Shared Lua scripts
├── ui/              # React frontend
│   ├── src/
│   │   ├── Dashboard.jsx    # Main dashboard
│   │   ├── Frame.jsx        # Main container
│   │   ├── Navbar.jsx       # Navigation bar
│   │   ├── Outfits.jsx      # Outfit management
│   │   ├── Ranks.jsx        # Rank system
│   │   ├── Settings.jsx     # Configuration
│   │   └── ...
│   └── public/
│       └── wll.png         # Logo
└── fxmanifest.lua          # FiveM manifest
```

## 📦 Dependencies

### UI Dependencies
- React 19.1.0
- TailwindCSS 4.1.10
- Motion (Framer Motion) 12.18.1
- Lucide React 0.518.0
- Vite 6.3.5

### Development Dependencies
- ESLint with React plugins
- Vite React plugin
- TypeScript definitions

## 🎮 Usage

1. **Open the menu** (configure your keybind in client scripts)
2. **Navigate** through different sections using the top navigation
3. **Manage players** - recruit, promote, or remove members
4. **Track finances** - monitor income and expenses
5. **Configure settings** - customize the menu to your needs

## 🔧 Configuration

The menu can be customized through:
- [`shared/main.lua`](shared/main.lua) - Shared configuration
- [`ui/src/Translations.js`](ui/src/Translations.js) - Language settings
- [`ui/src/Settings.jsx`](ui/src/Settings.jsx) - UI preferences

## 🌟 Features in Development

- [ ] Complete player management system
- [ ] Advanced rank permissions
- [ ] Financial transaction history
- [ ] Outfit customization
- [ ] Multi-language support
- [ ] Database integration

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Hatcyk** - *Lead Developer*
- **Logerys** - *Co-Developer*

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact the development team

## ⚠️ Notice

**This is a TRIAL VERSION** - Some features may be limited or incomplete. The full version includes additional functionality and complete integration.

---

**Made by WeLoveLua**