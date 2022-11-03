module.exports = {
  plugins: [require("flowbite/plugin")],
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./node_modules/flowbite/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        accent: {
          register: "#FFC42D",
          header: "#53ABE0",
          logo: "#00A3FF",
        },
        main: {
          white: "#FFFFFF",
          black: "#333333",
          blue: "#27B1FF",
          bluehover: "#5AC4FF",
          red: "#FF764A",
          redhover: "#FF9472",
          bg: "#CFEEFF",
        },
        line: {
          100: "#D7D7D7",
        },
      },
      keyframes: {
        flashFade: {
          "0%": { transform: "translateX(180px)", opacity: 0 },
          "20%": { transform: "translateX(0)", opacity: 1 },
          "80%": { transform: "translateX(0)", opacity: 1 },
          "100%": { transform: "translateX(180px)", opacity: 0 },
        },
      },
      animation: {
        flash: "flashFade 7.0s forwards",
      },
      fontFamily: {
        logo: ["Jomhuria"],
        body: ["Noto Sans JP"],
      },
    },
  },
};
