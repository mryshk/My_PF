/* global $ */

$(function(){
  $('#form').validate({
    rules:{
      "post[post_tweet]": {
        required: true,
        maxlength: 140
      },
    },
    messages: {
      "post[post_tweet]": {
        required: "投稿文を入力してください。"
      },
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
  });
});