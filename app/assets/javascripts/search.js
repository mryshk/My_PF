
/* global $ */
/* global location */
/* global searchResult */
/* global inputForm */
/* global NoResult */
// インクリメンタルサーチ


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
      searchResult.empty();
      if(data.length !== 0) {
        data.forEach(function(data){
          $('.search-post .table').remove();
          $('.search-post').append(
            `<table class="table table-borderless">
                <tr>
                  <td class="align-middle" style="width:60px; padding:0;">
                    <p style="font-size:12px; margin-bottom:0px;">${data.name}</p>
                  </td>
                  <td class="align-middle">
                    <a href="posts/${data.id}" class="link">
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