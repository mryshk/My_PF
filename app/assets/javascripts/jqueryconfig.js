/* global $ */

$(function(){
  $('#form').validate({
    rules:{
      "post[post_tweet]": {
        required: true,
        maxlength: 140
      },
      "post[post_url]": {
        required: true,
      },
      "album[name]": {
        required: true,
      },
      "album[caption]": {
        maxlength: 140,
      },
      "album[album_url]": {
        required: true,
      },
      "album_music[name]":{
        required: true,
      },
      "album_music[caption]": {
        maxlength: 140,
      },
      "album_music[music_url]":{
        required: true,
      }
    },
    messages: {
      "post[post_tweet]": {
        required: "投稿文を入力してください。"
      },
      "post[post_url]": {
        required: "音楽のURL（Youtubeや音楽サブスク等）を入力してください。"
      },
      "album[name]": {
        required: "アルバム名を入力してください。"
      },
      "album[caption]":{
        required: "１４０文字以内で入力してください。"
      },
      "album[album_url]":{
        required: "アルバムのURL（Youtubeや音楽サブスク等）を入力してください。"
      },
      "album_music[name]": {
        required: "楽曲名を入力してください。"
      },
      "album_music[caption]":{
        required: "１４０文字以内で入力してください。"
      },
      "album_music[music_url]":{
        required: "楽曲のURL（Youtubeや音楽サブスク等）を入力してください。"
      },
    },
    errorClass: "invalid",
    errorElement: "p",
    validClass: "valid",
  });
});