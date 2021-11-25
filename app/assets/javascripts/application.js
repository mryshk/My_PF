// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require jquery
//= require jquery.jscroll.min.js
//= require skippr.min.js
//= require jquery.raty.js
//= require search.js
//= require jqueryconfig.js
//= require jquery_ujs
//= require turbolinks
//= require_tree .

/* global $this */
/* global $next */
/* global scrollHeight */
/* global gon */
/* global $ */
/* global click */
/* global jQuery */


$(document).on('turbolinks:load',function () {
  $("#theTarget").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'fade',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : 'bubble',
    // 子要素の種類('div' or 'img')
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : true,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 2000,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : true,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});

// ページTOPボタン・TOPスクロール
$(document).on('turbolinks:load',function(){
  $('#page-top').on('click',function(event){
    $('body,html').animate({
      scrollTop:0
    },800);
    event.preventDefault();
  });
});

$(document).on('turbolinks:load',function() {
    var pagetop = $('#page-top');
    pagetop.hide();
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {  //100pxスクロールしたら表示
            pagetop.fadeIn();
        } else {
            pagetop.fadeOut();
        }
    });
});


$(document).on('turbolinks:load', function(){
  $('.menu-trigger').on('click', function(event){
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    event.preventDefault();
  });
});

var beforePos = 0;//スクロールの値の比較用の設定

//スクロール途中でヘッダーが消え、上にスクロールすると復活する設定を関数にまとめる
function ScrollAnime() {
    var elemTop = $('#area-1').offset(); //#area-2の位置まできたら
  var scroll = $(window).scrollTop();
    //ヘッダーの出し入れをする
    if(scroll == beforePos) {
    //IE11対策で処理を入れない
    }else if(elemTop > scroll || 0 > scroll - beforePos){
    //ヘッダーが上から出現する
    $('#header').removeClass('UpMove'); //#headerにUpMoveというクラス名を除き
    $('#header').addClass('DownMove');//#headerにDownMoveのクラス名を追加
    }else {
    //ヘッダーが上に消える
        $('#header').removeClass('DownMove');//#headerにDownMoveというクラス名を除き
    $('#header').addClass('UpMove');//#headerにUpMoveのクラス名を追加
    }

    beforePos = scroll;//現在のスクロール値を比較用のbeforePosに格納
}


// 画面をスクロールをしたら動かしたい場合の記述
$(document).on('turbolinks:load',function(){
  $(window).scroll(function () {
  ScrollAnime();//スクロール途中でヘッダーが消え、上にスクロールすると復活する関数を呼ぶ
  });
})


$(document).on('turbolinks:load',function(){
  $('#search').on('click',function(event){
    $("#search-form").fadeToggle(500);
    $('body,html').animate({
      scrollTop:0
    },800);
    event.preventDefault();
  });
});

// メニューバー

$(document).on('turbolinks:load',function() {
  var Accordion = function(el, multiple) {
    this.el = el || {};
    this.multiple = multiple || false;

    // Variables privadas
    var links = this.el.find('.link');
    // Evento
    links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
  }

  Accordion.prototype.dropdown = function(e) {
    var $el = e.data.el;
      $this = $(this),
      $next = $this.next();

    $next.slideToggle();
    $this.parent().toggleClass('open');

    if (!e.data.multiple) {
      $el.find('.submenu').not($next).slideUp().parent().removeClass('open');
    };
  }

  var accordion = new Accordion($('#accordion'), false);
});

$(document).on('turbolinks:load',function() {
    $('.js-modal-open').on('click',function(){
        $('.js-modal').fadeIn();
        return false;
    });
    $('.js-modal-close').on('click',function(){
        $('.js-modal').fadeOut();
        return false;
    });
});


// 無限スクロール
$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    // 無限に追加する要素のクラス名
    contentSelector: '.jscroll',
    // 次のページにいくためのリンクの場所を指定
    nextSelector: 'a.next',
    // 読み込み中の文言の表示
    loadingHtml: 'Now loading'
  });
});

// マイページのタブ機能

$(document).on('turbolinks:load',function(){
  $('.tab').click(function(){
    $('.tab-active').removeClass('tab-active');
    $(this).addClass('tab-active');
    $('.box-show').removeClass('box-show');
    const index = $(this).index();
    $('.tabbox').eq(index).addClass('box-show');
  });
});

// linkpreview用のJavascript
// post/show album/show album_music/showの３つのviewで使用。
const data = {
  key: gon.linkpreview_key, //環境変数化済み。gem/gon使用。
  q: gon.url,
}
//プレビュー表示用の関数
// 取得したJSON形式の情報を各IDへ付与。
const createIMG = json => {
  document.querySelector('#link_img').src = json.image;
  document.querySelector('#linktitle').textContent = json.title;
  document.querySelector('#linkcaption').textContent = json.description;
  document.querySelector('#link').href = json.url;
}
//LinkPreviewを利用した通信処理
// 情報をJSON形式で取得
fetch('https://api.linkpreview.net', {
  method: 'POST',
  mode: 'cors',
  body: JSON.stringify(data),
})
.then(data => data.json())
.then(json => createIMG(json));