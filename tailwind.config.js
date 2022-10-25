module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
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
          bg: "#CFEEFF",
        },
        line: {
          100: "#D7D7D7",
        },
      },
      fontFamily: {
        logo: ["Jomhuria"],
        body: ["Noto Sans JP"],
      },
    },
  },
};
