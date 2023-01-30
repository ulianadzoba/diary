# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin "lodash", to: "https://ga.jspm.io/npm:lodash@4.17.21/lodash.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "animate.css", to: "https://ga.jspm.io/npm:animate.css@4.1.1/animate.css"
pin '@nathanvda/cocoon', to: 'https://ga.jspm.io/npm:@nathanvda/cocoon@1.2.14/cocoon.js'
pin '@oddcamp/cocoon-vanilla-js', to: 'https://ga.jspm.io/npm:@oddcamp/cocoon-vanilla-js@1.1.3/index.js'
pin 'swiper', to: 'https://ga.jspm.io/npm:swiper@7.4.1/swiper.esm.js'
pin 'dom7', to: 'https://ga.jspm.io/npm:dom7@4.0.4/dom7.esm.js'
pin 'ssr-window', to: 'https://ga.jspm.io/npm:ssr-window@4.0.2/ssr-window.esm.js'
