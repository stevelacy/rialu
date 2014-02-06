$(document).ready(function(){

  $('#location, #keyboard-box, body #toast').hide();

  var socket = io.connect('//node.la:5000');
  socket.on('connect', function() {
    console.log('connect');
  });


  socket.on('gps', function(gps){
    gps = gps.gps.gps;
    $('#location').fadeIn();
    $('#map').html('').append('<h3>Accuracy: '+gps.accuracy+'</h3><iframe width="100%" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?q='+gps.latitude+'++'+gps.longitude+'&amp;output=embed"></iframe>');
  });

  socket.on('reply', function(reply){
    reply = reply.reply;
    if (reply.message == "connected") return $('#toast').fadeIn(400).text(reply.device+" "+reply.message).delay(500).fadeOut();
    if (reply.message == "Panic Started!") return checkDesktop(reply.device, reply.message);
    $('#toast').fadeIn(400).text(reply.message).delay(500).fadeOut();
  });

  $('#panic').click(function(){
    socket.emit('panic', {panic:'panic', client:client});
  });
  $('#lock').click(function(){
    socket.emit('lock', {lock:'lock', client:client});
  });
  $('#horn').click(function(){
    socket.emit('horn', {horn:'horn', client:client});
  });
  $('#gps').click(function(){
    socket.emit('gps', {gps:'gps', client:client});
  });

  $('#keyboard').click(function(){
    $('#keyboard-box').fadeIn();
  });
  $('body #close').click(function(){
    $(this).parent().fadeOut();
  });

  $('#keyboard-set').click(function(keyboard){
    data = {
      left: {
        color: $('#color-left').val(),
        intensity: $('#intensity-left').val()
      },
      middle: {
        color: $('#color-center').val(),
        intensity: $('#intensity-center').val()
      },
      right: {
        color: $('#color-right').val(),
        intensity: $('#intensity-right').val()
      },
    };
    socket.emit('keyboard', {data:data, client:client});
    console.log(data);
  });


  $(document).on('click', '#delete-item', function(e) {
    e.preventDefault();
    socket.emit('delete',{delete:$(this).attr('data-id')});
    $(this).parent().remove();
  });

  var sendCommand = function(command){
    socket.emit('command', {command:command, client:client});
  };


  $('#slider').slider({
    value: 50,
    slide: function(e, ui){
      $('#volume').text(ui.value);
    },
    change: function(e, ui){
      socket.emit('volume', {volume:ui.value, client:client});
    }
  });

  $('#command-form').submit(function(){
    sendCommand($('#command').val());
    $('#command').val('');
    return false;
  });

});