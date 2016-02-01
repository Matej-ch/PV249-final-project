/*
$(document).ready(function(){
    $.ajax({
        url: Routes.user_friendships_path({format: 'json'}),
        dataType: 'json',
        type: 'GET',
        success: function (data) {
            window.userFriendships = data;
        }
    });

    $('#add-friendship').click(function(e) {
        e.preventDefault();
        var btnfriendship = $(this);
        $.ajax({
            url: Routes.user_friendships_path({user_friendship: {friend_id: btnfriendship.data('friendId')}}),
            dataType: 'json',
            type: 'POST',
        success: function(event){
        btnfriendship.hide();
        $('#friend-status').html("<a href='#' class='btn btn-success'>FriendZone Requested</a>");
    }
    });
});
});*/
