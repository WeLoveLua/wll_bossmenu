import Navbar from './Navbar.jsx';
import Dashboard from './Dashboard.jsx';

export default function Frame() {
  return (
    <div className="w-[900px] h-[900px] border border-gray-300 rounded-lg overflow-hidden fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2">
      <Navbar />
      <Dashboard />
    </div>
  );
}
