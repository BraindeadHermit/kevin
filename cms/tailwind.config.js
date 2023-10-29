/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{jsx,js,html}"],
  theme: {
    extend: {
      colors: {
        primary: {
          main: '#009688',
          variant: '#00695F',
        },
        secondary: {
          main: '#D500F9',
          variant: '#9500AE',
        },
      },
      fontFamily: {
        body: 'Inter',
      }
    }
  },
  plugins: [],
};
