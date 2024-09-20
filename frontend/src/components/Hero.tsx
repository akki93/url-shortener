import bgImg from '../assets/hero.svg';

const Hero = () => {
    return (
      <section className="bg-white text-gray-700 py-20">
        <div className="container mx-auto flex items-center justify-between ">
          <div className="text-center md:text-left md:w-1/2 ">
            <h2 className="text-5xl font-extrabold mb-4">Shorten Your URLs Instantly</h2>
            <p className="text-lg mb-8">Paste your URL below to shorten and share!</p>
            <div className="flex justify-center md:justify-start space-x-4">
            <input
                type="text"
                className="w-1/2 px-4 py-2 text-black rounded-lg border-2 border-gray-300 focus:border-blue-600 focus:ring focus:ring-blue-200 transition duration-300"
                placeholder="Enter your URL here"
            />
              <button className="px-6 py-2 bg-black font-semibold text-white rounded-lg hover:bg-blue-600 transition">
                Shorten URL
              </button>
            </div>
          </div>
          <div className="hidden md:block md:w-1/2">
            <img
              src={bgImg} // Replace with your image path
              alt="Hero Image"
              className="w-full h-auto"
              draggable="false"
            />
          </div>
        </div>
      </section>
    );
  };
  
  export default Hero;
  