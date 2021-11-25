/* global $ */

// バリデーション＆アラート文をjQueryで導入。
// プラグイン「jquery.validate.js」を活用。
$(function(){
  $('#form').validate({
    rules:{
       // 以下つぶやき投稿のバリデーション
      "post[post_tweet]": {
        required: true,
        maxlength: 140
      },
      "post[post_url]": {
        required: true,
      },
      // 以下アルバム投稿のバリデーション
      "album[name]": {
        required: true,
      },
      "album[caption]": {
        maxlength: 140,
      },
      "album[album_url]": {
        required: true,
      },
      // 以下楽曲投稿のバリデーション
      "album_music[name]":{
        required: true,
      },
      "album_music[caption]": {
        maxlength: 140,
      },
      "album_music[music_url]":{
        required: true,
      },
      // 以下アルバム投稿のバリデーション
      "group[name]":{
        required: true,
      },
      "group[introduction]":{
        maxlength: 140,
      },
      // 以下お問い合わせ機能のバリデーション
      "inquiry[name]":{
        required: true,
      },
      "inquiry[email]":{
        required: true,
      },
      "inquiry[message]":{
        maxlength: 300,
      },
    },
    // 以下アラート分
    messages: {
      // 以下つぶやき投稿のアラート文
      "post[post_tweet]": {
        required: "投稿文を入力してください。"
      },
      "post[post_url]": {
        required: "音楽のURL（Youtubeや音楽サブスク等）を入力してください。"
      },
      // 以下アルバム投稿のアラート文
      "album[name]": {
        required: "アルバム名を入力してください。"
      },
      "album[caption]":{
        required: "１４０文字以内で入力してください。"
      },
      "album[album_url]":{
        required: "アルバムのURL（Youtubeや音楽サブスク等）を入力してください。"
      },
      // 以下楽曲投稿のアラート文
      "album_music[name]": {
        required: "楽曲名を入力してください。"
      },
      "album_music[caption]":{
        required: "140文字以内で入力してください。"
      },
      "album_music[music_url]":{
        required: "楽曲のURL（Youtubeや音楽サブスク等）を入力してください。"
      },
      // 以下グループ作成のアラート文
      "group[name]":{
        required: "グループ名を入力してください。"
      },
      "group[introduction]":{
        required: "140文字以内で入力してください。"
      },
      // 以下お問合わせ機能のアラート文
      "inquiry[name]":{
        required: "グループ名を入力してください。"
      },
      "inquiry[email]":{
        required: "メールアドレスを入力してください。"
      },
      "inquiry[message]":{
        required: "300文字以内で入力してください。"
      },
    },
    // 失敗した際に以下クラス名付与
    errorClass: "invalid",
    // アラート文の要素
    errorElement: "p",
    // 成功した際に以下クラス名付与
    validClass: "valid",
  });
});