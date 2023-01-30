const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './config/initializers/simple_form_tailwindcss.rb'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        'nunito-sans': ['Nunito Sans'],
        'gilroy': ['Gilroy'],
        'pacifico': ['Pacifico'],
        'source-code': ['SourceCodePro'],
      },
      fontSize: {
        '2xxl': '1.75rem',
        '3xxl': '2rem',
        '4xxl': '2.75rem',
        '7xs': '4rem',
      },
      colors: {
        'base-beige': 'rgb(247, 242, 235)',
        'accents-brown': 'rgba(116, 89, 70, 1)',
        'bright-brown': 'rgb(201, 179, 153)',
        'accents-dark': '#162035',
        'primary-white': '#FAFAFA',
        'dynamic': 'var(--dynamic-color)',
        'base-green': 'rgb(156, 219, 156)',
        'base-red': 'rgba(219, 150, 155, 1)',
        'base-yellow': 'rgba(237, 237, 164, 1)',
        'base-gray': 'rgba(227, 223, 214, 1)',
      },
      padding: {
        '18': '4.5rem',
      },
      height: {
        '55': '13.75rem',
      },
      spacing: {
        '18': '4.5rem',
        '26': '6.5rem',
        '34': '8.5rem',
        '42': '10.5rem',
        '50': '12.5rem',
        '58': '14.5rem',
      },
      flex: {
        '2': '2 2 0%',
      },
      borderRadius: {
        'xs': '0.125rem',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
