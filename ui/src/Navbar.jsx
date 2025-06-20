import { motion } from "motion/react";
import { Users, Shield, DollarSign, Settings, Shirt, LayoutDashboard, LogOut } from "lucide-react";

export default function Navbar() {
    const navItems = [
        { name: "Dashboard", icon: LayoutDashboard, href: "#", active: true },
        { name: "Players", icon: Users, href: "#" },
        { name: "Ranks", icon: Shield, href: "#" },
        { name: "Finance", icon: DollarSign, href: "#" },
        { name: "Outfits", icon: Shirt, href: "#" },
        { name: "Settings", icon: Settings, href: "#" }
    ];

    const handleLogout = () => {
        // Check if running in FiveM
        if (window.invokeNative) {
            // FiveM environment - send NUI message to close
            fetch(`https://${window.GetParentResourceName()}/close`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({})
            });
        } else {
            // Browser environment - close window
            window.close();
        }
    };

    return (
        <nav className="bg-slate-800 border-b border-slate-700 sticky top-0 z-50">
            <div className="max-w-6xl mx-auto px-6">
                <div className="flex items-center justify-between h-16">
                    {/* Logo */}
                    <div className="flex items-center">
                        <img 
                            src="/wll.png" 
                            alt="WLL Logo" 
                            className="w-12 h-12 rounded-full border border-slate-600"
                        />
                    </div>
                    
                    {/* Navigation */}
                    <div className="flex items-center space-x-1">
                        {navItems.map((item) => (
                            <motion.a
                                key={item.name}
                                href={item.href}
                                whileHover={{ y: -1 }}
                                whileTap={{ scale: 0.98 }}
                                className={`relative px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200 flex items-center space-x-2 ${
                                    item.active 
                                        ? "bg-blue-600 text-white" 
                                        : "text-slate-300 hover:text-white hover:bg-slate-700"
                                }`}
                            >
                                <item.icon className="w-4 h-4" />
                                <span className="hidden md:inline">{item.name}</span>
                                
                                {/* Active indicator */}
                                {item.active && (
                                    <motion.div
                                        layoutId="activeTab"
                                        className="absolute bottom-0 left-1/2 w-6 h-0.5 bg-white rounded-full transform -translate-x-1/2"
                                        transition={{ type: "spring", stiffness: 400, damping: 30 }}
                                    />
                                )}
                            </motion.a>
                        ))}
                        
                        {/* Logout Button */}
                        <motion.button
                            onClick={handleLogout}
                            whileHover={{ y: -1 }}
                            whileTap={{ scale: 0.98 }}
                            className="px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-200 flex items-center text-red-400 hover:text-red-300 hover:bg-slate-700 ml-2"
                        >
                            <LogOut className="w-4 h-4" />
                            <span className="hidden md:inline">Logout</span>
                        </motion.button>
                    </div>
                </div>
            </div>
        </nav>
    );
}
