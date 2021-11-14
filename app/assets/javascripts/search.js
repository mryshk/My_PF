
/* global $ */
/* global location */
/* global searchResult */
/* global inputForm */
/* global NoResult */
// インクリメンタルサーチ

// Post用
$(document).on('turbolinks:load',function(){

  $("#searching-form").on('keyup',function(){
    console.log("キーボードを入力した時に発生");
    let target = $("#searching-form").val();
    console.log(target);

    $.ajax({
    type: 'GET',
    url: "/posts/search",
    data: {keyword: target},
    dataType: 'json'
    })
    .done(function(data){
      console.log(data);
      $('.search-post').empty();
      if(data.length !== 0) {
        data.forEach(function(data){
          // $('.search-post .table').remove();
          $('.search-post').append(
            `<table class="table table-borderless">
                <tr>
                  <td class="align-middle" style="width:60px; padding:0;">
                    <p style="font-size:12px; margin-bottom:0px;">${data.name}</p>
                  </td>
                  <td class="align-middle">
                    <a href="posts/${data.id}" class="link" data-turbolinks="false" >
                      <p class="card-text text-center mt-2">${data.post_tweet}</p>
                    </a>
                  </td>
                </tr>
              </table>
            `
            );
          // builtHTML(data)
        });
      }
    });
  });
});


// アルバム一覧用
$(document).on('turbolinks:load',function(){

  $("#searching-form-home-album").on('keyup',function(){
    console.log("キーボードを入力した時に発生");
    let target = $("#searching-form-home-album").val();
    console.log(target);

    $.ajax({
    type: 'GET',
    url: "artist/albums/search",
    data: {keyword: target},
    dataType: 'json'
    })
    .done(function(data){
      console.log(data);
      $('.search-post-home-album').empty();
      if(data.length !== 0) {
        data.forEach(function(data){
          // $('.search-post .table').remove();
          $('.search-post-home-album').append(
            `<table class="table table-borderless">
                <tr>
                  <td class="align-middle text-center" style="width:60px; padding:0;">
                    <a href="artist/creaters/${data.creater}" class="link"data-turbolinks="false">
                      <p style="font-size:16px; margin-bottom:0px;">${data.creater_name}</p>
                    </a>
                  </td>
                  <td class="align-middle text-center">
                    <a href="artist/albums/${data.id}" class="link " data-turbolinks="false">
                      <p style="font-size:22px; margin-bottom:0px;">${data.name}</p>
                    </a>
                  </td>
                </tr>
              </table>
            `
            );
          // builtHTML(data)
        });
      }
    });
  });
});


// アルバムホーム画面用
$(document).on('turbolinks:load',function(){

  $("#searching-form-album").on('keyup',function(){
    console.log("キーボードを入力した時に発生");
    let target = $("#searching-form-album").val();
    console.log(target);

    $.ajax({
    type: 'GET',
    url: "albums/search",
    data: {keyword: target},
    dataType: 'json'
    })
    .done(function(data){
      console.log(data);
      $('.search-post-album').empty();
      if(data.length !== 0) {
        data.forEach(function(data){
          // $('.search-post .table').remove();
          $('.search-post-album').append(
            `<table class="table table-borderless">
                <tr>
                  <td class="align-middle text-center" style="width:60px; padding:0;">
                    <a href="creaters/${data.creater}" class="link"data-turbolinks="false">
                      <p style="font-size:16px; margin-bottom:0px;">${data.creater_name}</p>
                    </a>
                  </td>
                  <td class="align-middle text-center">
                    <a href="albums/${data.id}" class="link " data-turbolinks="false">
                      <p style="font-size:22px; margin-bottom:0px;">${data.name}</p>
                    </a>
                  </td>
                </tr>
              </table>
            `
            );
          // builtHTML(data)
        });
      }
    });
  });
});