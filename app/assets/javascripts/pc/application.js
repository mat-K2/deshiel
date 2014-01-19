// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $('.comment_button').click(function() {
    if ($('div.comment.' + $(this).attr('line_num')).css('display') == 'none') {
      $('div.comment').css('display', 'none');
      $('div.comment.' + $(this).attr('line_num')).css('display', '');
    } else {
      $('div.comment.' + $(this).attr('line_num')).css('display', 'none');
    }
  });

  $('form input.help, form textarea.help').formtips({
    tippedClass: 'tipped'
  });

  $('.help.tipped').keyup(function() {
    if ($(this).val().length >= 1) {
      $('#regist_objective').removeAttr('disabled');
    }else{
      $('#regist_objective').attr('disabled', 'disabled');
    }
  });
});
