
const Navbar = () => {
  return (
    <nav className="bg-white text-black py-4 border-b border-gray-300">
      <div className="container mx-auto flex justify-between items-center">
        <h1 className="text-3xl font-bold">Url.Shortify</h1>
        <div className="flex space-x-6">
            <button className="bg-gray-300 text-gray-600 font-semibold rounded"><a href="/signup">Sign Up</a></button>
            <div className="border-l-2 border-gray-300 h-10 mx-4"></div> {/* Adjust height as needed */}
            <button className="bg-gray-300 text-gray-700 font-semibold rounded"><a href="/login">Login</a></button>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;
