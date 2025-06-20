import { motion } from "motion/react";
import { 
    Users, 
    DollarSign, 
    TrendingUp, 
    Settings, 
    UserPlus, 
    Briefcase,
    Shield,
    Car
} from "lucide-react";

export default function Dashboard() {
    const stats = [
        { label: "Total Members", value: "24", icon: Users, color: "text-blue-500" },
        { label: "Balance", value: "$125,430", icon: DollarSign, color: "text-green-500" },
        { label: "Weekly Income", value: "$15,200", icon: TrendingUp, color: "text-purple-500" },
        { label: "Owned Vehicles", value: "12", icon: Car, color: "text-orange-500" }
    ];

    const quickActions = [
        { label: "Recruit Member", icon: UserPlus, color: "bg-blue-600" },
        { label: "Manage Ranks", icon: Shield, color: "bg-purple-600" },
        { label: "View Finances", icon: Briefcase, color: "bg-green-600" },
        { label: "Settings", icon: Settings, color: "bg-gray-600" }
    ];

    return (
        <div className="min-h-screen bg-gray-900 p-6">
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                className="max-w-6xl mx-auto space-y-8"
            >
                {/* Header */}
                <div className="text-center">
                    <h1 className="text-4xl font-bold text-white mb-2">Boss Menu</h1>
                    <p className="text-gray-400">Manage your organization</p>
                </div>

                {/* Stats Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                    {stats.map((stat, index) => (
                        <motion.div
                            key={stat.label}
                            initial={{ opacity: 0, scale: 0.9 }}
                            animate={{ opacity: 1, scale: 1 }}
                            transition={{ delay: index * 0.1 }}
                            className="bg-gray-800 rounded-lg p-6 border border-gray-700"
                        >
                            <div className="flex items-center justify-between">
                                <div>
                                    <p className="text-gray-400 text-sm">{stat.label}</p>
                                    <p className="text-2xl font-bold text-white">{stat.value}</p>
                                </div>
                                <stat.icon className={`w-8 h-8 ${stat.color}`} />
                            </div>
                        </motion.div>
                    ))}
                </div>

                {/* Quick Actions */}
                <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
                    <h2 className="text-xl font-semibold text-white mb-4">Quick Actions</h2>
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        {quickActions.map((action, index) => (
                            <motion.button
                                key={action.label}
                                whileHover={{ scale: 1.05 }}
                                whileTap={{ scale: 0.95 }}
                                className={`${action.color} text-white p-4 rounded-lg flex flex-col items-center gap-2 transition-colors hover:opacity-90`}
                            >
                                <action.icon className="w-6 h-6" />
                                <span className="text-sm font-medium">{action.label}</span>
                            </motion.button>
                        ))}
                    </div>
                </div>

                {/* Recent Activity */}
                <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
                    <h2 className="text-xl font-semibold text-white mb-4">Recent Activity</h2>
                    <div className="space-y-3">
                        {[
                            "John Doe joined the organization",
                            "Weekly payment of $5,000 received",
                            "Territory expanded to Downtown",
                            "New rank 'Lieutenant' created"
                        ].map((activity, index) => (
                            <motion.div
                                key={index}
                                initial={{ opacity: 0, x: -20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: index * 0.1 }}
                                className="flex items-center gap-3 p-3 bg-gray-700 rounded-lg"
                            >
                                <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
                                <span className="text-gray-300">{activity}</span>
                            </motion.div>
                        ))}
                    </div>
                </div>
            </motion.div>
        </div>
    );
}
