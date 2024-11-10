module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}"
  ],
  theme: {
    extend: {
      colors: {
        'wenge': '#655560',
        'lavender-pink' : '#ffb8d1',
        'orchid-pink' : '#e4b4c2',
        'thistle': '#e7cee3',
        'light-cyan' : '#ddfdfe',
      },
      fontFamily: {
        custom: ['ExposureTrial', 'sans-serif'],
        customi: ['ExposureTrial-i', 'sans-serif'],
        inter: ['Inter', 'sans-serif'],
      },
      keyframes: {
        slideUp: {
          '0%': { transform: 'translateY(0)', opacity: '1' },
          '100%': { transform: 'translateY(-100%)', opacity: '0' },
        },
        slideDown: {
          '0%': { transform: 'translateY(0)', opacity: '1' },
          '100%': { transform: 'translateY(100%)', opacity: '0' },
        },
        fadeOut: {
          '0%': { opacity: '1' },
          '100%': { opacity: '0' },
        },
        slideIn: {
          '0%': { transform: 'translateY(-100%)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
        slideOut: {
          '0%': { transform: 'translateX(-100%)', opacity: '0' },
          '100%': { transform: 'translateX(0)', opacity: '1' },
        },
        RslideOut: {
          '0%': { transform: 'translateX(0)', opacity: '0' },
          '100%': { transform: 'translateX(100%)', opacity: '1' },
        },
        LslideOut: {
          '0%': { transform: 'translateX(0)', opacity: '1' },
          '100%': { transform: 'translateX(-100%)', opacity: '0' },
        }
      },
      animation: {
        slideUp: 'slideUp 1s forwards',
        slideDown: 'slideDown 1s forwards',
        fadeOut: 'fadeOut 1s ease-out forwards',
        slideIn: 'slideIn 1s ease-out forwards',
        LslideIn: 'slideOut 1s ease-out forwards',
        RslideOut: 'RslideOut 1s ease-out forwards',
        LslideOut: 'LslideOut 1s ease-out forwards'
      },
    },
  },
  plugins: [],
};
