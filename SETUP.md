# WLL Boss Menu - Setup Instructions

## Prerequisites

Before using this boss menu, ensure you have the following dependencies installed on your FiveM server:

1. **es_extended** (ESX Framework)
2. **ox_lib** (OX Library)
3. **ox_target** (OX Target System)
4. **MySQL-Async** or **oxmysql** (for database operations)
5. **esx_addonaccount** (for society accounts)

## Installation

1. Place the `wll_bossmenu` folder in your server's `resources` directory
2. Add `ensure wll_bossmenu` to your `server.cfg`
3. Make sure the dependencies are loaded before this resource

## Configuration

Edit `shared/main.lua` to customize:

- **Target Distance**: How close players need to be to interact
- **Boss Grades**: Which job grades can access the boss menu (default: 2, 3, 4)
- **Job Restrictions**: Specific jobs that can use the menu (empty = all jobs)
- **Financial Limits**: Maximum withdraw/deposit amounts
- **UI Settings**: Keybind support and notification settings

## Target Zones

The script includes an example ox_target zone at coordinates:
- **Location**: `-541.0, -216.0, 37.65` (Mission Row PD example)

To customize target locations:

1. Edit `client/main.lua`
2. Find the `ox_target:addBoxZone` section
3. Update coordinates to your desired locations
4. Add multiple zones for different organizations

## Usage

### For Players:
- Approach a configured target zone
- Use ox_target interaction (default: Alt + E)
- Select "Open Boss Menu" option

### For Server Administrators:
- Players need job grade 2 or higher to access boss menu
- Society accounts must be set up for each job via esx_addonaccount
- Database tables must be properly configured

## Features Implemented

✅ **ESX Integration**: Full compatibility with ESX framework
✅ **OX Library**: Uses ox_lib for notifications and callbacks
✅ **OX Target**: Integration with ox_target for interaction
✅ **Player Management**: Hire, fire, and promote employees
✅ **Financial Management**: Withdraw/deposit society money
✅ **Grade System**: Respect ESX job grade hierarchy
✅ **Permissions**: Proper permission checking
✅ **Real-time Updates**: Live data refresh
✅ **Modern UI**: React-based interface with animations

## Troubleshooting

### Common Issues:

1. **Menu won't open**:
   - Check if player has correct job grade (2+)
   - Verify dependencies are loaded
   - Check console for errors

2. **NUI not loading**:
   - Ensure UI was built properly (`npm run build` in ui folder)
   - Check if `ui/dist/` folder exists

3. **Database errors**:
   - Verify MySQL connection
   - Check if ESX tables exist
   - Ensure esx_addonaccount is configured

4. **Target not working**:
   - Verify ox_target is installed and running
   - Check target zone coordinates
   - Ensure player is close enough to zone

## Support

For support and customization:
- Check FiveM console for error messages
- Verify all dependencies are up to date
- Test with a fresh ESX installation

---

**Made by WeLoveLua - Hatcyk & Logerys**