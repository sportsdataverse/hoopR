
const outcomes = [
  "How to build this landing page with Next.js",
  "How to create API endpoint and integrate with ConvertKit API",
  "How to use React Hook Form and TailwindCSS",
];

const ComingSoonBadge = () => (
  <span className="bg-blue-500 text-white text-xs py-1 px-2 rounded-md mb-4 inline-block">
    Coming Soon!
  </span>
);

const Hero = () => {
  return (
    <div className="border border-gray-200 md:flex md:flex-row">
      <div className="px-4 md:px-8 py-6 self-center md:w-2/3">
        <h2 className="font-bold text-2xl mb-3">What you'll learn</h2>
        {outcomes && (
          <ul className="mb-6">
            {outcomes.map((i) => (
              <li key={i} className="text-gray-700 flex mb-2">
                <span className="opacity-75">{i}</span>
              </li>
            ))}
          </ul>
        )}
        <ComingSoonBadge />
        <div>SIGNUP FORM GOES HERE</div>
      </div>
    </div>
  );
};

export default Hero;