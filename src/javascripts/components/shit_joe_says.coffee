# React Globals
React         = require('react')
DOM           = require('tbg_react_dom')

# Helpers
Quotes        = require('../data/quotes.coffee');

# Mixins

# Components
SocialButton  = React.createFactory(require('./social_button.coffee'))

# Flux


# Component
#
# @mixin
#
# @author Sam
#
ShitJoeSays =

  # --------------------------------------------
  # Defaults
  # --------------------------------------------

  displayName   : 'ZlatanSays'
  propTypes     : {
                  }
  mixins        : []


  # --------------------------------------------
  # Getters & Checkers - get/has/can/is
  # --------------------------------------------

  getInitialState: ->
    quote       : 0

  getDefaultProps: ->


  getQuote: ->
    rand = Math.floor(Math.random() * Quotes.length)
    if @state and rand == @state.quote
      @getQuote()
    else
      @setState quote: rand

    window.location.hash = rand

  getQueryString: (name) ->

  # --------------------------------------------
  # Lifecycle Methods
  # --------------------------------------------

  componentWillMount: ->          # add event listeners (Flux Store, WebSocket, document)@
    # I'm about to get the query string!
    if window.location.hash
      id = parseInt window.location.hash.substr(1);
      @setState quote: id if !isNaN(id)
    else
      @getQuote()

  componentWillReceiveProps: ->   # change state based on props change
  componentDidMount: ->           # data request (XHR)
  componentWillUnmount: ->        # remove event listeners


  # --------------------------------------------
  # Event handlers
  # --------------------------------------------

  _handleClick: (e) ->
    @getQuote()



  # --------------------------------------------
  # Render methods
  # --------------------------------------------

  render: ->
    DOM.div({
        className: 'joe-says'
        },
      DOM.div({ className: 'question' }, Quotes[ @state.quote ].question )
      DOM.h1({ className: 'title', onClick: @_handleClick }, 'shit joe says' )
      DOM.div({ className: 'click', onClick: @_handleClick }, 'click for a quote' )
      DOM.div({ className: 'quote' },
        DOM.div({ className: 'image' })
        Quotes[ @state.quote ].quote
      )

      SocialButton({
        buttonType    : 'facebook'
        buttonText    : 'Share'
        title         : "#{Quotes[ @state.quote ].quote}"
        link          : 'https://shit-joe-says.herokuapp.com/'
        caption       : "#{Quotes[ @state.quote ].question}"
        picture       : 'https://shit-joe-says.herokuapp.com/img/joe.jpg'
        redirect_uri  : 'https://zlatan-says.herokuapp.com/'
      })

      SocialButton({
        buttonType    : 'twitter'
        buttonText    : 'Tweet'
        title         : Quotes[ @state.quote ].quote
        link          : 'https://shit-joe-says.herokuapp.com/'
        hashtags      : 'ShitJoeSays'
      })
    )


module.exports = React.createClass(ShitJoeSays)
