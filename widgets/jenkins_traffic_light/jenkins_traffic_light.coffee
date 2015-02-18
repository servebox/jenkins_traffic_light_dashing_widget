class Dashing.JenkinsTrafficLight extends Dashing.Widget
    ready: ()->
        changeLight($(@node), @get('status'))
    onData: (data) ->
        changeLight(@get('node'), data.status)
    changeLight=(node, status)->
        toggleClass(node, status)
        toggleClass('.bottom-shade', status)

        $('.light').css('opacity',0.1)
        $('.'+status).css('opacity',1)
        
    toggleClass=(node, status)->
        $(node).removeClass('red')
        $(node).removeClass('orange')
        $(node).removeClass('green')
        $(node).addClass(status)